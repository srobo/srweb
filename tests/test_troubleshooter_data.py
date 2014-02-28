
import os

import helpers

def test_data_file():
    the_json = helpers.ensure_valid_json('resources/troubleshooter/data.json')
    assert 'askiffixed_question' in the_json
    assert 'questions' in the_json

def check_key_is_valid_string(id_, the_dict, key):
    msg = "The {} should be a useful string".format(id_)

    assert key in the_dict, msg
    value = the_dict[key]
    assert value is not None, msg
    assert value is not '', msg

    assert str(value) == value, msg

def check_question(id_, question_data):
    msg = "question (for '{}')".format(id_)
    check_key_is_valid_string(msg, question_data, 'question')

    assert 'answers' in question_data, id_
    answers = question_data['answers']
    assert isinstance(answers , list), "The answers (for '{}') should be a list".format(id_)
    assert len(answers) > 0, "There must be at least one answer for '{}'.".format(id_)

    for i, ans_data in enumerate(answers):
        msg = "{0}th answer to question '{1}'".format(i, id_)
        check_key_is_valid_string(msg, ans_data, 'answer')

        for maybe_key in ['message', 'nextquestion']:
            if maybe_key in ans_data:
                msg = "{1} attribute of the {0}th answer to question '{2}'".format(i, maybe_key, id_)
                check_key_is_valid_string(msg, ans_data, 'answer')

def test_questions():
    the_json = helpers.ensure_valid_json('resources/troubleshooter/data.json')

    questions = the_json['questions']
    askiffixed_question = the_json['askiffixed_question']
    check_question('askiffixed_question', askiffixed_question)

    for id_, question_data in questions.items():
        check_question(id_, question_data)

def test_nextquestion():
    the_json = helpers.ensure_valid_json('resources/troubleshooter/data.json')

    questions = the_json['questions']

    next_questions = set()

    for id_, question_data in questions.items():
        assert 'answers' in question_data, id_
        answers = question_data['answers']

        for ans_data in answers:
            if 'nextquestion' in ans_data:
                next_questions.add(ans_data['nextquestion'])

    all_questions = set(questions.keys())
    missing = next_questions - all_questions

    assert missing == set(), "Some questions link to missing questions"

    # Also remove the 'root' question, which has an empty id
    unlinked = all_questions - next_questions - set([""])

    assert unlinked == set(), "Some questions are never used"
