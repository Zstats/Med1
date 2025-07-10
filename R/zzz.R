#' @keywords internal
#' @importFrom utils readline
#' @importFrom utils packageVersion
#' @importFrom utils packageStartupMessage

.onLoad <- function(libname, pkgname) {
  forbidden <- c("trace", "debug", "browser", "edit", "get", "recover")
  for (f in forbidden) {
    if (exists(f, envir = .GlobalEnv, inherits = FALSE)) {
      stop(sprintf("检测到调试函数 %s，操作被禁止！", f))
    }
  }

  packageStartupMessage('正在加载包的依赖项...')

  if (!requireNamespace("utils", quietly = TRUE)) {
    stop("需要安装 'utils' 包")
  }
  # checkManage()
  # #suppressWarnings({
  # #  untrace("med_cal", where = asNamespace(pkgname))
  # #})
  # #f <- get("med_cal", envir =  asNamespace(pkgname))
  # #lockEnvironment(environment(f), bindings = TRUE)
  # 
  # packageStartupMessage("授权成功！请继续访问")
}

#' @keywords internal
.onAttach <- function(libname, pkgname) {
  version <- utils::packageVersion(pkgname)
  cat("version")
  packageStartupMessage(sprintf("欢迎zhp使用 %s (版本 %s)", pkgname, version))
  validate_environment()
}



#' 验证运行环境
#' @keywords internal
validate_environment <- function() {
  # 示例：检查R版本
  if (getRversion() < "4.0.0") {
    warning("建议使用 R 4.0.0 或更高版本")
  }

  # 示例：检查必要的系统环境变量
  required_env_vars <- c("R_HOME")
  missing_vars <- required_env_vars[!required_env_vars %in% names(Sys.getenv())]

  if (length(missing_vars) > 0) {
    warning(sprintf("缺少必要的环境变量: %s", paste(missing_vars, collapse = ", ")))
  }

  # 这里可以添加更多自定义的验证逻辑
  TRUE
}
