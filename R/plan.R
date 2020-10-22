plan <- drake_plan(
  fertility_raw = read_xlsx(
    file_in("data/indicator-undata-total-fertility.xlsx")),
  fertility = clean_data(fertility_raw),
  line_plot_all = plot_fertility_all(fertility, alpha = 0.1),
  oz = fertility %>% filter(country == "Australia"),
  line_plot_oz = plot_fertility_all(oz, alpha = 1),
  mod = lm(babies_per_woman ~ year1950, data = oz),
  mod_plot = plot_model_fit(mod, oz),
  report = rmarkdown::render(
    knitr_in("report.Rmd"),
    output_file = file_out("report.html"),
    quiet = TRUE
  )
)
