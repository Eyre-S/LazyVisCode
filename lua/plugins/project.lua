return {
  "ahmedkhalf/project.nvim",
  lazy = false,
  opts = {
    manual_mode = false,
    detection_methods = { "lsp", "pattern" },
    patterns = {
      ".git", "_darcs", ".hg", ".bzr", ".svn",
      "lua",
      "Makefile", "CMakeList.txt",
      "build.gradle", "pom.xml", "build.sbt",
      "*.sln", "*.csproj",
      "package.json",
      "requirements.txt", "pyproject.toml",
      "Cargo.toml", "go.mod",
      "composer.json", "pubspec.yaml",
    },
  },
}

