create_bayesreg_table <- function(
  modellist,
  modelnames,
  cirange = .95,
  savedir
){
  if(!requireNamespace("brms")) install.packages("brms")
  if(!requireNamespace("BayesPostEst")) install.packages("BayesPostEst")

  print(
    BayesPostEst::mcmcReg(
      modellist,
      format = "latex",
      hpdi = TRUE,
      ci = cirange,
      custom.model.names = modelnames,
      doctype = F
    ),
    file = savedir
  )
}
