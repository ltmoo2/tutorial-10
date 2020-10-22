clean_data <- function(data) {
  data %>%
    clean_names() %>%
    rename(country = total_fertility_rate) %>%
    pivot_longer(cols = -c(country), # everything but country,
                 # what is the name of the new variable we are changing the
                 # column of names to?
                 names_to = "year",
                 # What is the name of the column we are changing the values to?
                 values_to = "babies_per_woman") %>%
    # extract out the year information
    mutate(year = parse_number(year)) %>%
    # filter so we only look at years above 1950
    filter(year >= 1950 ) %>%
    # center year around 1950
    mutate(year1950 = year - min(year))
}

plot_fertility_all <- function(data, alpha = 1){
  ggplot(data,
         aes(x = year,
             y = babies_per_woman,
             group = country)) +
    geom_line(alpha=alpha)
}

plot_model_fit <- function(model, data){
  model %>%
    augment_columns(data) %>%
    ggplot(aes(x = year, y = babies_per_woman)) +
    geom_line() +
    geom_point(aes(y = .fitted))
}
