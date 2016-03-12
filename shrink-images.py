#!/usr/bin/env python

"""PNG image shrinking script backed by pngquant

Images are shrunk by using the pngquant command-line tool. You may install
it before running this script, but if missing (or too old) the script will
help you build it.
"""

from __future__ import print_function

import fnmatch
import os
from queue import Queue, Empty
import subprocess
import sys
from threading import Thread

if sys.version_info[0] == 3:
    raw_input = input

def side_file(name):
    return os.path.join(os.path.dirname(os.path.abspath(__file__)), name)

IMAGES_ROOT = side_file('images')
IMAGE_DIRS = ('content', 'template')

SHRUNK_FILE_NAME = '.shrunk-images'
SHRUNK_FILES = None

PNGQUANT_HOME = side_file('.pngquant')
PNGQUANT_PATH = os.path.join(PNGQUANT_HOME, 'pngquant', 'pngquant')

def threadpool(action, datas):
    if not datas:
        return

    # Use threading to do some at the same time
    q = Queue()
    for data in datas:
        q.put(data)

    def worker():
        while True:
            try:
                data = q.get_nowait()
            except Empty:
                return
            else:
                action(data)
                q.task_done()

    # Build our pool
    threads = []
    for n in range(4):
        t = Thread(target=worker, name='worker-'+str(n))
        threads.append(t)
        t.start()

    # Wait for completeion
    q.join()

    # Tidy our threads
    for t in threads:
        t.join()

def ensure_pngquant():
    """Attempts to ensure that a suitable version of pngquant is available,
        with input from the user. Returns whether or not a suitable version
        was made available."""

    global PNGQUANT_PATH

    def check_version(pngquant_path):
        version = subprocess.check_output([pngquant_path, '--version'])

        num = version.split()[0]
        ver = tuple(map(int, num.split('.')))
        if ver < (2, 6, 0):
            err_msg = "Version of pngquant too old (got {0}, must be >= 2.6)." \
                      " Do NOT use versions older than 2.0."
            raise Exception(err_msg.format(num))

    def check_libpng(pngquant_path):
        help_info = subprocess.check_output([pngquant_path, '--help'])
        lines = help_info.splitlines()
        for line in lines:
            if line.startswith("WARNING:"):
                raise Exception(line)

    def q_use_anyway(error):
        yes_opts = ('y',)
        no_opts = ('n', '')
        options = yes_opts + no_opts
        question = "{0} Use anyway? [y/N]: ".format(error)
        while True:
            answer = raw_input(question).lower()
            if answer not in options:
                print('Invalid input!')
            else:
                break

        return answer in yes_opts

    create_local = False
    if os.path.exists(PNGQUANT_PATH):
        # Found a local install, try it
        pngquant_path = PNGQUANT_PATH
        try:
            check_version(PNGQUANT_PATH)
            check_libpng(PNGQUANT_PATH)
        except Exception as e:
            print(e)
            print(e.message, file=sys.stderr)
            return q_use_anyway("Local version unsuitable.")
        else:
            return True
    else:
        # Check for a global install
        try:
            pngquant_path = subprocess.check_output(['which', 'pngquant'])
            check_version(pngquant_path)
            check_libpng(pngquant_path)
        except subprocess.CalledProcessError as cpe:
            print("No installed version found.", file=sys.stderr)
            return False
        except Exception as e:
            print(e.message, file=sys.stderr)
            return q_use_anyway("Installed version unsuitable.")
        else:
            PNGQUANT_PATH = pngquant_path
            return True

def recursive_glob(root, pattern):
    # recursive glob not available in Python 2
    # via https://stackoverflow.com/a/2186565/67873
    matches = []
    for curr_dir, _, filenames in os.walk(root):
        for filename in fnmatch.filter(filenames, pattern):
            matches.append(os.path.join(curr_dir, filename))

    return matches

def find_all_pngs():
    all_pngs = []
    for dir_ in IMAGE_DIRS:
        all_pngs += recursive_glob(dir_, '*.png')
    return all_pngs

def has_been_shrunk(file_path):
    global SHRUNK_FILES
    if SHRUNK_FILES is None:
        if not os.path.exists(SHRUNK_FILE_NAME):
            SHRUNK_FILES = []
        else:
            with open(SHRUNK_FILE_NAME, 'r') as sf:
                SHRUNK_FILES = [l.strip() for l in sf.readlines()]

    return file_path in SHRUNK_FILES

def find_pngs_to_shrink():
    os.chdir(IMAGES_ROOT)

    all_pngs = find_all_pngs()
    if not all_pngs:
        exit("Didn't find any png images!")

    to_shrink = [png_path for png_path in all_pngs
                 if not has_been_shrunk(png_path)]
    return to_shrink

def shrink(file_path):
    try:
        subprocess.check_call([PNGQUANT_PATH, '--force',
                                              '--skip-if-larger',
                                              '--speed', '1',
                                              '--output', file_path,
                                              file_path])
    except subprocess.CalledProcessError as cpe:
        if cpe.returncode == 98:
            print("Could not improve '{0}', skipping.".format(file_path))
        else:
            print("Conversion of '{0}' failed.".format(file_path))

def convert_pngs(to_shrink):
    global SHRUNK_FILES

    assert to_shrink, "No images to process!"

    threadpool(shrink, to_shrink)

    SHRUNK_FILES += to_shrink
    SHRUNK_FILES.sort()

    with open(SHRUNK_FILE_NAME, 'w') as sf:
        print("\n".join(SHRUNK_FILES), file=sf)

def total_size(paths):
    total = sum(os.path.getsize(path) for path in paths)
    return total

def sizeof_fmt(num, suffix='B'):
    # Via https://stackoverflow.com/a/1094933/67873
    for unit in ('','Ki','Mi','Gi','Ti','Pi','Ei','Zi'):
        if abs(num) < 1024.0:
            return "%3.1f%s%s" % (num, unit, suffix)
        num /= 1024.0
    return "%.1f%s%s" % (num, 'Yi', suffix)

def print_change(orig_size, new_size):
    difference = orig_size - new_size
    assert difference >= 0, "Files became larger!"

    pc_diff = difference * 100.0 / orig_size
    abs_diff = sizeof_fmt(difference)

    print("Files shrunk by {0:.1f}% ({1}).".format(pc_diff, abs_diff))

if __name__ == '__main__':
    to_shrink = find_pngs_to_shrink()

    orig_size = total_size(to_shrink)

    if not to_shrink:
        exit("No images needed shrinking")
    else:
        print("Found {} images to shrink".format(len(to_shrink)))

    if not ensure_pngquant():
        exit("Please install a suitable version of pngquant.\n" \
             "A handy script 'get-pngquant' exists for this purpose:\n" \
             "$ bash get-pngquant .pngquant")

    convert_pngs(to_shrink)

    print_change(orig_size, total_size(to_shrink))
