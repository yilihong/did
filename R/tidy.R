#' tidy results
#' @export
generics::tidy

#' tidy results
#' @export
generics::glance

#' tidy results from MP objects
#'
#' @importFrom generics tidy
#' @param x a model of class MP produced by the `att_gt` function
#' @param ... Additional arguments to tidying method.
#' @export
tidy.MP <- function(x, ...) {
  out <- data.frame(
    term      = paste0('ATT(',x$group,",",x$t, ")"),
    group     = x$group,
    time      = x$t,
    estimate  = x$att,
    std.error = x$se,
    conf.low  = x$att - x$c * x$se,
    conf.high = x$att + x$c * x$se,
    point.conf.low  = x$att - stats::qnorm(1 - x$alp/2) * x$se,
    point.conf.high = x$att + stats::qnorm(1 - x$alp/2) * x$se)
  out
}

#' glance model characteristics from MP objects
#'
#' @importFrom generics glance
#' @param x a model of class MP produced by the `att_gt` function
#' @param ... other arguments passed to methods
#' @export
glance.MP <- function(x, ...) {
  out <- data.frame(
    nobs          = x$n,
    ngroup        = x$DIDparams$nG,
    ntime         = x$DIDparams$nT,
    control.group = x$DIDparams$control_group,
    est.method    = x$DIDparams$est_method)
  out
}

#' tidy results from AGGTEobj objects
#'
#' @importFrom generics tidy
#' @param x a model of class AGGTEobj produced by the `aggte` function
#' @param ... Additional arguments to tidying method.
#' @export
tidy.AGGTEobj<- function(x, ...) {
  if(x$type == "dynamic"){
    out <- data.frame(
      type          = x$type,
      event.time= x$egt,
      estimate  = x$att.egt,
      std.error = x$se.egt,
      conf.low  = x$att.egt - x$crit.val.egt * x$se.egt,
      conf.high = x$att.egt + x$crit.val.egt * x$se.egt,
      point.conf.low  = x$att.egt - stats::qnorm(1 - x$DIDparams$alp/2) * x$se.egt,
      point.conf.high = x$att.egt + stats::qnorm(1 - x$DIDparams$alp/2) * x$se.egt)
  }
  if(x$type == "group"){
    out <- data.frame(
      type     = x$type,
      group    = x$egt,
      estimate  = x$att.egt,
      std.error = x$se.egt,
      conf.low  = x$att.egt - x$crit.val.egt * x$se.egt,
      conf.high = x$att.egt + x$crit.val.egt * x$se.egt,
      point.conf.low  = x$att.egt - stats::qnorm(1 - x$DIDparams$alp/2) * x$se.egt,
      point.conf.high = x$att.egt + stats::qnorm(1 - x$DIDparams$alp/2) * x$se.egt)
  }

  if(x$type == "calendar"){
    out <- data.frame(
      type      = x$type,
      time      = x$egt,
      estimate  = x$att.egt,
      std.error = x$se.egt,
      conf.low  = x$att.egt - x$crit.val.egt * x$se.egt,
      conf.high = x$att.egt + x$crit.val.egt * x$se.egt,
      point.conf.low  = x$att.egt - stats::qnorm(1 - x$DIDparams$alp/2) * x$se.egt,
      point.conf.high = x$att.egt + stats::qnorm(1 - x$DIDparams$alp/2) * x$se.egt)
  }

  if(x$type == "simple"){
    out <- data.frame(
      type      = x$type,
      estimate  = x$overall.se,
      std.error = x$overall.se,
      conf.low  = x$overall.se - stats::qnorm(1 - x$DIDparams$alp/2) * x$overall.se,
      conf.high = x$overall.se + stats::qnorm(1 - x$DIDparams$alp/2) * x$overall.se,
      point.conf.low  = x$overall.se - stats::qnorm(1 - x$DIDparams$alp/2) * x$overall.se,
      point.conf.high = x$overall.se + stats::qnorm(1 - x$DIDparams$alp/2) * x$overall.se)
  }

  out
}

#' glance model characteristics from AGGTEobj objects
#'
#' @importFrom generics glance
#' @param x a model of class AGGTEobj produced by the `aggte` function
#' @param ... other arguments passed to methods
#' @export
glance.AGGTEobj<- function(x, ...) {
  out <- data.frame(
    type          = x$type,
    nobs          = x$DIDparams$n,
    ngroup        = x$DIDparams$nG,
    ntime         = x$DIDparams$nT,
    control.group = x$DIDparams$control_group,
    est.method    = x$DIDparams$est_method)
  out
}
