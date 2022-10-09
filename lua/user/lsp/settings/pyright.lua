return {
  cmd = { "py" },
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        diagnosticMode = "openFilesOnly",
        inlayHints = {
          variableTypes = true,
          functionReturnTypes = true,
        },
      },
    },
  },
}
