(function() {
    var data = { };
    var globalRadioName = 0;

    function init() {
        globalRadioName = 0;

        var resetBtnAtTop = document.getElementById("resetbtnattop");
        resetBtnAtTop.style.display = "none";

        var troubleshooter = document.getElementById("troubleshooter");
        troubleshooter.innerHTML = "";

        if (window.location.hash != "") {
            resetBtnAtTop.style.display = "inline-block";
        }

        var id = window.location.hash.substr(1); // substr to remove # on fragment
        appendQuestionById(troubleshooter, id);
    }

    function answerClicked(radioBtn, parent, answer) {
        parent.innerHTML = "";

        if ("message" in answer) {
            var newMessage = document.createElement('p');
            newMessage.className = "message";
            newMessage.innerHTML = answer.message;
            parent.appendChild(newMessage);
        }

        if ("askiffixed" in answer) {
            var question = data.askiffixed_question;
            question.answers[1].nextquestion = answer.nextquestion;
            appendQuestion(parent, question);
            return;
        }

        if (!("nextquestion" in answer)) {
            var newMessage = document.createElement("p");
            newMessage.className = "message";
            newMessage.textContent = "Thank you for using the SR Troubleshooter.";
            parent.appendChild(newMessage);

            var resetBtnAtTop = document.getElementById("resetbtnattop");
            resetBtnAtTop.style.display = "inline-block";

            return;
        }

        appendQuestionById(parent, answer.nextquestion);
    }

    function appendQuestionById(parent, id) {
        if (id != '') {
            window.location.hash = "#" + id;
        }
        var question = data.questions[id];
        appendQuestion(parent, question);
    }

    function fixLinks(text) {
        return text.replace(/ROOT_URL/g, ROOT_URL);
    }

    function appendQuestion(parent, question) {
        var newQuestionCont = document.createElement("div");

        var newQuestionDiv = document.createElement("div");
        newQuestionDiv.className = "question";

        var questionParagraph = document.createElement("p");
        questionParagraph.innerHTML = fixLinks(question.question);
        newQuestionDiv.appendChild(questionParagraph);

        var questionForm = document.createElement("form");
        newQuestionDiv.appendChild(questionForm);

        globalRadioName++;

        for (var i = 0; i < question.answers.length; i++) {
            (function(answer) {
                var answerLabel = document.createElement("label");

                var answerRadioBtn = document.createElement("input");
                answerRadioBtn.type = "radio";
                answerRadioBtn.name = globalRadioName;
                answerRadioBtn.onclick = function() {
                    answerClicked(answerRadioBtn, newQuestionCont, answer);
                };

                var answerSpan = document.createElement("span");
                answerSpan.textContent = fixLinks(answer.answer);

                answerLabel.appendChild(answerRadioBtn);
                answerLabel.appendChild(answerSpan);
                questionForm.appendChild(answerLabel);
            }(question.answers[i]))
        }

        parent.appendChild(newQuestionDiv);
        parent.appendChild(newQuestionCont);
    }

    jQuery.getJSON(TroubleshooterDataURL, function(json, textStatus, xhr) {
        data = json;

        if (data) {
            init();
        } else {
            var noQuestions = document.getElementById("troubleshooter_no_questions");
            noQuestions.style.display = "block";
        }
    });
}());
