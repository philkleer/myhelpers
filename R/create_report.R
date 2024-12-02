#' Create a quarto report file
#'
#' Creates personal quarto template for a report in working directory.
#'
#' @param filename The name of the created file. You don't have
#'  to add \code{.qmd}.
#' @param draftname The path to the draft file. If not indicated, the package
#'  included draft file will be used.
#' @param ext_name The name of extension to get the files from.
#'  Default 'myhelpers'.
#' @param path_to_chrome The path to location of puppeteer chrome distribution.
#'
#' @returns \code{qmd}-file for a \code{html}-report based on the template.
#'  Installs necessary extensions to render the \code{qmd}-file.
#'
#' @examples
#' # create_report(
#' #   filename = NULL,
#' #   draftname = '_extensions/myhelpers/draft-report.qmd',
#' #   ext_name = 'myhelpers',
#' #   path_to_chrome = '/Users/phil/.cache/puppeteer/chrome/mac_arm-119.0.6045.105/'
#' # )
#'
#' @importFrom cli cli_alert_success cli_progress_step cli_alert_info
#'  cli_alert_danger
#' @importFrom utils install.packages
#'
#' @export
create_report <- function(
    filename = NULL,
    draftname = '_extensions/myhelpers/draft-report.qmd',
    ext_name = 'myhelpers',
    path_to_chrome = '/Users/phil/.cache/puppeteer/chrome/mac_arm-119.0.6045.105/'
) {

  if(!requireNamespace('cli')) install.packages('cli')

  if (is.null(filename)) {
    stop('You must provide a valid filename')
  }

  out_dir <- getwd()

  # check for available extensions
  stopifnot('Extension not in package' = ext_name %in% c('myhelpers'))

  # check for existing _extensions directory
  if(!file.exists('_extensions')) dir.create('_extensions')
  cli::cli_alert_success('Created `_extensions` folder')

  # Create folder for recursive copying into ahead of time
  if(!file.exists(paste0('_extensions/', ext_name)))
    dir.create(paste0('_extensions/', ext_name))
  cli::cli_alert_success('Created `_extensions/myhelpers` folder')

  # Create folder for recursive copying into ahead of time
  if(!file.exists(paste0('_extensions/MyReport')))
    dir.create(paste0('_extensions/MyReport'))
  cli::cli_alert_success('Created `_extensions/MyReport` folder')

  # copy from internals
  cli::cli_progress_step(
    'Copying template files and style files ...',
    spinner = TRUE
  )

  # Copying _brand.yml
  file.copy('_extensions/myhelpers/_brand.yml', './')

  # copy my template
  file.copy(
    from = system.file(
      paste0(
        'extdata/_extensions/',
        ext_name
      ),
      package = 'myhelpers'
    ),
    to = paste0('_extensions/'),
    overwrite = TRUE,
    recursive = TRUE,
    copy.mode = TRUE
  )

  # copy MyReport typst template
  # DOES NOT WORK
  # file.copy(
  #   from = '_extensions/MyReport',
  #   to = './_extensions/',
  #   recursive = TRUE
  # )

  # Create folder for recursive copying into ahead of time
  if (draftname == '_extensions/myhelpers/draft-report.qmd') {
    file.copy(
      from = '_extensions/myhelpers/assets/',
      to = './',
      recursive = TRUE
    )
  }

  # create new qmd report based on skeleton
  readLines(draftname) |>
    writeLines(
      text = _,
      con = paste0(filename, '.qmd', collapse = '')
    )

  cli::cli_progress_step(
    'Installing quarto extensions ...',
    spinner = TRUE
  )

  # Copying extensions and puppeteer
  # Since usage of Positron right now more
  # if (!dir.exists('./_extensions/jmbuhr/qrcode')) {
  #   install <- rstudioapi::terminalExecute(
  #     'quarto install extension jmbuhr/quarto-qrcode'
  #   )
  #
  #   while (is.null(rstudioapi::terminalExitCode(install))) {
  #     Sys.sleep(2)
  #   }
  #
  #   rstudioapi::terminalKill(install)
  #
  #   cli::cli_alert_success('Extension `qrcode` has been created.')
  # } else {
  #   cli::cli_alert_info('Extension `qrcode` already exists.')
  # }
  #
  # if (!dir.exists('./_extensions/martinomagnifico/simplemenu')) {
  #   install2 <- rstudioapi::terminalExecute(
  #     'quarto add martinomagnifico/quarto-simplemenu'
  #   )
  #
  #   while (is.null(rstudioapi::terminalExitCode(install2))) {
  #     Sys.sleep(2)
  #   }
  #
  #   rstudioapi::terminalKill(install2)
  #
  #   cli::cli_alert_success('Extension `simplemenu` has been created.')
  # } else {
  #   cli::cli_alert_info('Extension `simplemenu` already exists.')
  # }
  #
  # if (!dir.exists('./_extensions/mcanouil/iconify')) {
  #
  #   install3 <- rstudioapi::terminalExecute(
  #     'quarto add mcanouil/quarto-iconify'
  #   )
  #
  #   while (is.null(rstudioapi::terminalExitCode(install3))) {
  #     Sys.sleep(2)
  #   }
  #
  #   rstudioapi::terminalKill(install3)
  #
  #   cli::cli_alert_success('Extension `iconify` has been created.')
  # } else {
  #   cli::cli_alert_info('Extension `iconify` already exists.')
  # }
  #
  # if (!dir.exists('./_extensions/quarto-ext/fontawesome')) {
  #
  #   install4 <- rstudioapi::terminalExecute('quarto add quarto-ext/fontawesome')
  #
  #   while (is.null(rstudioapi::terminalExitCode(install4))) {
  #     Sys.sleep(2)
  #   }
  #
  #   rstudioapi::terminalKill(install4)
  #
  #   cli::cli_alert_success('Extension `fontawesome` has been created.')
  # } else {
  #   cli::cli_alert_info('Extension `fontawesome` already exists.')
  # }
  #
  # if (!dir.exists('./_extensions/schochastics/academicons')) {
  #   install5 <- rstudioapi::terminalExecute(
  #     'quarto install extension schochastics/academicons'
  #   )
  #
  #   while (is.null(rstudioapi::terminalExitCode(install5))) {
  #     Sys.sleep(2)
  #   }
  #
  #   rstudioapi::terminalKill(install5)
  #
  #   cli::cli_alert_success('Extension `academicons` has been created.')
  # } else {
  #   cli::cli_alert_info('Extension `academicons` already exists.')
  # }
  #
  # if (!dir.exists('./_extensions/sellorm/social-embeds')) {
  #   install6 <- rstudioapi::terminalExecute(
  #     'quarto install extension sellorm/quarto-social-embeds'
  #   )
  #
  #   while (is.null(rstudioapi::terminalExitCode(install6))) {
  #     Sys.sleep(2)
  #   }
  #
  #   rstudioapi::terminalKill(install6)
  #
  #   cli::cli_alert_success('Extension `social-embeds` has been created.')
  # } else {
  #   cli::cli_alert_info('Extension `social-embeds` already exists.')
  # }

  # Kopieren von puppeteer, damit decktape funktioniert für PDF Ausgabe
  # Chrome version ist die, die decktape braucht
  # (evtl. anpassen mit Neuerungen von Decktape)
  cli::cli_progress_step(
    'Copying puppeteer (PDF print) ...',
    spinner = TRUE
  )
  if (!dir.exists('./.cache/puppeteer/chrome/mac_arm-119.0.6045.105/')) {

    dir.create('./.cache/')

    dir.create('./.cache/puppeteer/')

    dir.create('./.cache/puppeteer/chrome/')

    dir.create('./.cache/puppeteer/chrome/mac_arm-119.0.6045.105/')

    string <- paste0(
      'cp -rv ',
      path_to_chrome,
      ' $(pwd)/.cache/puppeteer/chrome/mac_arm-119.0.6045.105/'
    )

    # install7 <- rstudioapi::terminalExecute(string)

    cli::cli_alert_success('Puppeteer Chrome installation has been copied.')
  } else {
    cli::cli_alert_danger(
      paste0(
        'There is already a .cache-Folder. Please check if you have a ',
        'puppeteer/chrome/mac_arm-119.0.6045.105/ folder. If not, copy it ',
        'manually from /Users/phil/.cache/ !'
      )
    )
  }

  cli::cli_alert_success('Report created.')
  # open the new file in the editor
  # file.edit(paste0(filename, '.qmd'))
}
