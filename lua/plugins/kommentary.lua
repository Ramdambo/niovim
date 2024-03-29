return {
  "b3nj5m1n/kommentary",
  config = function()
    require("kommentary.config").configure_language(
      {"c", "cpp"},
      {
        single_line_comment_string = "//"
      }
    )

    require("kommentary.config").configure_language(
      {"default"},
      {
        prefer_single_line_comments = true,
        use_consistent_indentation = true,
        ignore_whitespace = true
      }
    )
  end
}
