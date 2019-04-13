# https://stackoverflow.com/questions/21435339/data-table-vs-dplyr-can-one-do-something-well-the-other-cant-or-does-poorly

dat <- structure(list(id = c(1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 2L, 2L, 
                             2L, 2L, 2L, 2L, 2L, 2L), name = c("Jane", "Jane", "Jane", "Jane", 
                                                               "Jane", "Jane", "Jane", "Jane", "Bob", "Bob", "Bob", "Bob", "Bob", 
                                                               "Bob", "Bob", "Bob"), year = c(1980L, 1981L, 1982L, 1983L, 1984L, 
                                                                                              1985L, 1986L, 1987L, 1985L, 1986L, 1987L, 1988L, 1989L, 1990L, 
                                                                                              1991L, 1992L), job = c("Manager", "Manager", "Manager", "Manager", 
                                                                                                                     "Manager", "Manager", "Boss", "Boss", "Manager", "Manager", "Manager", 
                                                                                                                     "Boss", "Boss", "Boss", "Boss", "Boss"), job2 = c(1L, 1L, 1L, 
                                                                                                                                                                       1L, 1L, 1L, 0L, 0L, 1L, 1L, 1L, 0L, 0L, 0L, 0L, 0L)), .Names = c("id", 
                                                                                                                                                                                                                                        "name", "year", "job", "job2"), class = "data.frame", row.names = c(NA, 
                                                                                                                                                                                                                                                                                                            -16L))
# dplyr
dat %>%
  group_by(name, job) %>%
  filter(job != "Boss" | year == min(year)) %>%
  mutate(cumu_job2 = cumsum(job2))


#data.table
setDT(dat)[,
           .SD[job != "Boss" | year == min(year)][, cumjob := cumsum(job2)], 
           by=list(id, job)
           ]

