<?php

if (!ob_start('ob_gzhandler')) ob_start();

//get user configuration
require('config.inc.php');

//get smarty code
require(SMARTY_DIR . '/Smarty.class.php');

//get classes for constructing hierachical menu
require('classes/MenuItem.class.php');
require('classes/Menu.class.php');

//get class from extracting metadata and content
require('classes/Content.class.php');

//get instance of smarty
$smarty = new Smarty();

//$smarty->debugging = true;

//configure smarty
$smarty->template_dir = TEMPLATE_DIR;
$smarty->compile_dir = COMPILED_TEMPLATE_DIR;
$smarty->cache_dir = CACHE_DIR;

//get the page to serve (excl. language)
$page = getPage();

//get the prefered languages
$orderedLanguages = getOrderedLanguages();

//default language is en -- English
$language = 'en';

//use lowercase array keys for comparison (no mixed case issues then)
$accepted_languages = array_change_key_case($ACCEPTED_LANGUAGES, CASE_LOWER);

foreach($orderedLanguages as $l){

	//if it's a supported language...
	if (in_array(strtolower($l), $accepted_languages)){

		//and the relevent content filew exists...
		if (file_exists(CONTENT_DIR . '/' . $accepted_languages[strtolower($l)] . '/' . $page)){

			//this is the language to use
			$language = $accepted_languages[strtolower($l)];
			break;
		}

	}
}//foreach

//home and content files are treated differently, so if the page is 'home'
//serve the home template, otherwise use the content template.
if ($page == 'home'){

	$smarty->assign('side_menu', constructMenuHierachy());
	$smarty->assign('root_uri', ROOT_URI);
	$smarty->display('home.tpl');

} else {

	//the physical file to serve, including the language in the path
	$fileToServe = CONTENT_DIR . '/' . $language . '/' . $page;

	//before we go ahead and serve it, see if we can use what the
	//user's browser has cached.
	if (function_exists('apache_request_headers')){

		$headers = apache_request_headers();

		//if the file hasn't changed since the client last saw it, send a 304
		if (isset($headers['If-Modified-Since'])
			&& (strtotime($headers['If-Modified-Since']) == filemtime($fileToServe))){

			Header('Last-Modified: ' . gmdate('D, d M Y H:i:s',
				filemtime($fileToServe)).' GMT', true, 304);

			Header('Connection: close');

		} else {

			//otherwise serve it
			Header('Last-Modified: ' . gmdate('D, d M Y H:i:s',
				filemtime($fileToServe)).' GMT', true, 200);

		}//if else isset if-mod-since

	}//if function_exists


	//this is as far as we can get without opening a content file, so...

	$content = new Content($fileToServe);

	//called to allow access to the metadata
	$content->getParsedContent();

	//if the file is a special redirection file, do the redirection
	if ($content->getMeta('REDIRECT') != ""){
		Header("HTTP/1.1 302 Found");
		Header("Location: " . $content->getMeta('REDIRECT'));
	}

	//make the content object accessible in the templates (used by a custom smarty plugin)
	$smarty->assign('content', $content);


	//get ready to display the template
	$smarty->assign('original', $language . '/' . $page);
	$smarty->assign('content_dir', CONTENT_DIR);
	$smarty->assign('root_uri', ROOT_URI);

	//display content template
	$smarty->display('content.tpl');

}//if-else












/*
 * ===========================================================
 *                         FUNCTIONS
 * ===========================================================
 */

/*
 * Returns an ordered array (most prefered first) of languages
 * the client is happy with. If it's not set, then 'en' is the
 * default.
 */
function getOrderedLanguages(){

	if (!function_exists('apache_request_headers'))
		return array('en');

	$headers = apache_request_headers();

	if (!in_array('Accept-Language', array_keys($headers)))
		return array('en');

	$tags = explode(',', $headers['Accept-Language']);

	$pref_array = array();
	if (count($tags) > 0){

		$pattern = '/([A-Za-z]{2})(-[A-Za-z]{2})?(;q=[01]\.[0-9]+)?/';
		foreach ($tags as $tag){

			preg_match($pattern, $tag, $matches);
			$preference = array_key_exists(3, $matches) ? (float)str_replace(';q=', '', $matches[3]) : (float)1;
			$pref_array[$matches[1].$matches[2]] = $preference;

		}//foreach

		arsort($pref_array, SORT_NUMERIC);
		return array_keys($pref_array);

	} else {

		return array('en');

	}//if-else

}



/*
 * Returns a list of allowed files/directories, recursively,
 * from the given $directory. Mmmmm... recursion.
 */
function getAllowedPages($directory) {

	$array_items = array();

	if ($handle = opendir($directory)) {

		//read each item (file/dir) in $directory
		while (false !== ($file = readdir($handle))) {

			//ignore . and ..
			if (substr($file, 0, 1) != '.') {

				if (is_dir($directory. "/" . $file)){

					//get the listing for the directory as well
					$array_items = array_merge($array_items, getAllowedPages($directory. "/" . $file));

					//get the bit of path after the content dir
					$pattern = '/^' . str_replace('/', '\/', CONTENT_DIR . '/default') . '\/(.+)$/';
					preg_match($pattern, $directory. "/" . $file, $matches);
					$array_items[] = $matches[1] . '/';

					continue;

				}//if is_dir

				$file = $directory . "/" . $file;

				//ignore the extension fof the file paths, and get just the bit after 'content/'
				$pattern = '/^' . str_replace('/', '\/', CONTENT_DIR . '/default') . '\/(.+)$/';
				preg_match($pattern, $file, $matches);
				$array_items[] = $matches[1];

			}//if (not . or ..)

		}//while

		closedir($handle);

	}//if opened

	//remove spurious NULLs
	for ($i=0; $i<count($array_items); $i++)
		if ($array_items[$i] === NULL)
			unset($array_items[$i]);

	return $array_items;

}//getAllowedPages



/*
 * Returns the page to serve.
 */
function getPage(){

	$page = 'home';
	$allowed_pages = getAllowedPages(CONTENT_DIR . '/default');

	if (isset($_GET['page'])){

		if (in_array($_GET['page'], $allowed_pages)){

			$page = $_GET['page'];

		} elseif (in_array($_GET['page'] . '/', $allowed_pages)) {

			//redirect the browser to the more correct URL with trailing slash
			Header('HTTP/1.1 302 Found');
			Header('Location: ' . ROOT_URI . $_GET['page'] . '/');

		} else {

			//page not allowed / page not found -- respond with a 404
			Header('HTTP/1.1 404 Not Found');
			$page = '404';

		}//if-elseif-else

		//append 'index' if the 'page' requested is a directory
		if (substr($page, -1, 1) == '/')
			$page .= 'index';


	}//if isset

	return $page;

}//getPage



/*
 * Constructs a Menu (object) with a load of MenuItems (objects)
 * and to pass to the makemenu plugin (function.makemenu.php)
 * in the plugins/ dir. (For producing a ul/li-based menu).
 */
function constructMenuHierachy(){

	global $MENU_PAGES;
	$allowed_pages = getAllowedPages(CONTENT_DIR . '/default');

	$menu = new Menu();

	//ignore any menu page that doesn't exist
	$menu_pages = array_intersect($MENU_PAGES, $allowed_pages);

	//add each to the hierachy
	foreach (array_keys($menu_pages) as $index){

		$path = $menu_pages[$index];

		if (gettype($index) == 'string'){
			$menu->addToHierachy($path, ROOT_URI, $index);
		} else {
			$menu->addToHierachy($path, ROOT_URI);
		}

	}

	return $menu;

}//constructMenuHeirachy

?>
