test_that("selectors work", {
  ard_testing <- ard_categorical(ADSL, by = ARM, variables = AGE)

  expect_equal(
    ard_testing |>
      dplyr::select(all_ard_groups()) |>
      names(),
    c("group1", "group1_level")
  )
  expect_equal(
    ard_testing |>
      dplyr::select(all_ard_groups("names")) |>
      names(),
    "group1"
  )
  expect_equal(
    ard_testing |>
      dplyr::select(all_ard_groups("levels")) |>
      names(),
    "group1_level"
  )

  expect_equal(
    ard_testing |>
      dplyr::select(all_ard_variables()) |>
      names(),
    c("variable", "variable_level")
  )
  expect_equal(
    ard_testing |>
      dplyr::select(all_ard_variables("names")) |>
      names(),
    "variable"
  )
  expect_equal(
    ard_testing |>
      dplyr::select(all_ard_variables("levels")) |>
      names(),
    "variable_level"
  )

  # test group selector works for 10+ groups
  expect_equal(
    suppressMessages(
      rep_len(list(mtcars[c("am", "vs")]), length.out = 11) |> dplyr::bind_cols()
    ) |>
      ard_categorical(
        variables = "vs...2",
        by = starts_with("am"),
        statistic = ~"n"
      ) |>
      dplyr::select(all_ard_groups()) |>
      names() |>
      length(),
    22L
  )

  # all_ard_group_n() works
  expect_equal(
    ard_categorical(
      mtcars,
      by = c(am, vs),
      variables = cyl
    ) |>
      dplyr::select(all_ard_group_n(1L)) |>
      names(),
    c("group1", "group1_level")
  )

  expect_equal(
    ard_categorical(
      mtcars,
      by = c(am, vs),
      variables = cyl
    ) |>
      dplyr::select(all_ard_group_n(1:2)) |>
      names(),
    c("group1", "group1_level", "group2", "group2_level")
  )

  # all_missing_columns() works
  expect_equal(
    bind_ard(
      ard_categorical(mtcars, by = am, variables = cyl),
      ard_categorical(mtcars, variables = vs)
    ) |>
      dplyr::filter(variable == "vs") |>
      dplyr::select(all_missing_columns()) |>
      names(),
    c("group1", "group1_level", "warning", "error")
  )
})
