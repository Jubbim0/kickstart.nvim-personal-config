return {
  {
    "Jubbim0/nvim-edstem-guard",
    main = "edstem_guard",
    opts = {
      line_threshold = 20,
      repo_commands = {
        -- simple examples
        --[[ ["singly"] = { "make" },
        ["forward_list"] = { "make" },

        -- example for a multi-file repo
        ["assignment1"] = {
          "g++",
          "main.cpp",
          "helper.cpp",
          "-std=c++20",
          "-Wall",
          "-Wextra",
          "-o",
          "main", ]]
        },
      },
    },
  }

