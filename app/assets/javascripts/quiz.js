var quiz_conf = {};
var list = {};
var quizQuestions = [];
var currentQuestion = 0;
var state = "awaitingInput";
var errors = [];

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
}

function normalQuizCheck() {
  if (state == "awaitingInput") {
    var answer = $("#answer-input").val();
    $("#answer-input").hide();
    $("#answer-feedback").show();
    if (answer == word(currentQuestion, 2)) {
      $("#answer-feedback").html("Correct!");
    } else {
      $("#answer-feedback").html("Incorrect. The correct answer is: " + word(currentQuestion, 2));
      quizQuestions.splice(currentQuestion + 2 + Math.floor(Math.random() * 3), 0, quizQuestions[currentQuestion]);
      errors.push({id: quizQuestions[currentQuestion], userAnswer: answer});
    }
    $("#answer-input").val("");
    currentQuestion++;
    if (currentQuestion == quizQuestions.length) {
      $("#check-answer").val("View result");
    } else {
      $("#check-answer").val("Next word");
    }
    state = "viewingAnswer";
  } else {
    if (currentQuestion == quizQuestions.length) {
      alert("Redirect to result");
    }
    $("#answer-input").show();
    $("#answer-feedback").hide();
    $("#display-question").html(word(currentQuestion, 1));
    $("#check-answer").val("Check answer");
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
