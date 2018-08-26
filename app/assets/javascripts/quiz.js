var quiz_conf = {};
var list = {};
var quizQuestions = [];
var currentQuestion = 0;
var state = "awaitingInput";
var quiz_errors = [];
var correct = 0;

$('body.quiz-quiz').ready(function () {
  quiz_conf.quiz_type = parsed.quiz.quiz_type;
  quiz_conf.direction = parsed.quiz.direction;
  list = parsed.list;

  if (quiz_conf.quiz_type == "normal") {
    normalQuizInit();
  } else {
    alert("Can't initialize if I don't know what quiz this is :)");
  }
});

function normalQuizInit() {
  // In a normal quiz, we randomize the order of the words. After that, we display the next question.
  quizQuestions = Object.keys(list.links);
  shuffleArray(quizQuestions);
  $("#check-answer").click(normalQuizCheck);
  $(document).keypress(function(e) {
    if (e.which == 13) {
      normalQuizCheck();
    }
  });
  $("#display-question").html(word(0, 1));
  $("#answer-input").val("");
  $("#answer-input").focus();
}

function normalQuizCheck() {
  if (state == "awaitingInput") {
    var answer = $("#answer-input").val();
    $("#answer-input").hide();
    $("#answer-feedback").show();
    if (answer == word(currentQuestion, 2)) {
      $("#answer-feedback").html("Correct!");
      correct++;
    } else {
      $("#answer-feedback").html(parsed.t.incorrect_message + word(currentQuestion, 2));
      quizQuestions.splice(currentQuestion + 2 + Math.floor(Math.random() * 3), 0, quizQuestions[currentQuestion]);
      quiz_errors.push({word1: word(currentQuestion, 1), word2: word(currentQuestion, 2), answer: answer});
    }
    $("#answer-input").val("");
    currentQuestion++;
    if (currentQuestion == quizQuestions.length) {
      $("#check-answer").val(parsed.t.view_result);
    } else {
      $("#check-answer").val(parsed.t.next_word);
    }
    state = "viewingAnswer";
  } else {
    if (currentQuestion == quizQuestions.length) {
      $.ajax({
        type: "POST",
        url: $("meta[name=quiz_post_url]")[0].content,
        data: {
          authenticity_token: $('[name="csrf-token"]')[0].content,
          quiz_result: {
            direction: quiz_conf.direction,
            quiz_type: quiz_conf.quiz_type,
            correct: correct,
            quiz_errors_attributes: quiz_errors
          }
        },
        success: function(data){
          // The AJAX call made it through and data was returned.
          if (data["status"] == "success") {
            window.location.href = data["redirect_to"];
          } else {
            alert("The result could not be saved due to an error.");
          }
        },
        dataType: "json"
      }).fail(function(){alert("And error occurred while submitting");});
    }
    $("#answer-input").show();
    $("#answer-feedback").hide();
    $("#display-question").html(word(currentQuestion, 1));
    $("#answer-input").focus();
    state = "awaitingInput";
  }
}

function word(link_id, which){
  return list.links[quizQuestions[link_id]][keyForQuizQuestions(which)];
}

function keyForQuizQuestions(which) {
  if (which == 1) {
    if (quiz_conf.direction == "normal") {
      return "word1";
    } else {
      return "word2";
    }
  } else if (which == 2) {
    if (quiz_conf.direction == "normal") {
      return "word2";
    } else {
      return "word1";
    }
  }
}
