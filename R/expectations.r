is_a <- function(class) {
  function(x) {
    expect_result(
      inherits(x, class),
      paste("is not a ", class, sep = "")
    )
  }
}


is_true <- function() {
  function(x) {
    expect_result(
      identical(x, TRUE),
      "isn't true"
    )
  }
}


is_false <- function() {
  function(x) {
    expect_result(
      identical(x, FALSE),
      "isn't false"
    )
  }
}


equals <- function(expected) {
  name <- deparse(substitute(expected))
  function(actual) {
    expect_result(
      identical(all.equal(expected, actual), TRUE),
      paste("does not equal ", name, sep = "")
    )
  }
}

is_identical <- function(expected) {
  name <- deparse(substitute(expected))
  function(actual) {
    expect_result(
      identical(actual, TRUE),
      paste("is not not identical to ", name, sep = "")
    )
  }
}


matches <- function(regexp) {
  function(char) {
    expect_result(
      all(grepl(regexp, char)),
      paste("does not match ", regexp, sep = "")
    )
  }  
}


prints <- function(regexp) {
  function(expr) {
    output <- capture.output(force(expr))
    matches(regexp)(output)
  }  
}


throws_error <- function(regexp = NULL) {
  function(expr) {
    res <- try(force(expr), TRUE)
    if (!is.null(regexp)) {
      matches(regexp)(res)
    } else {
      is_a("try-error")(res)
    }
  }
} 