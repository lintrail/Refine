toys <- refine_original.csv
toys
install.packages("dplyr")
install.packages("tidyr")
library(dplyr)
library(tidyr)

toys[toys$company == "Phillips", "company"] <- "phillips"
toys[toys$company == "philips", "company"] <- "phillips"
toys[toys$company == "phllips", "company"] <- "phillips"
toys[toys$company == "phillps", "company"] <- "phillips"
toys[toys$company == "phlips", "company"] <- "phillips"
toys[toys$company == "fillips", "company"] <- "phillips"
toys[toys$company == "phillipS", "company"] <- "phillips"


toys[toys$company == "Akzo", "company"] <- "akzo"
toys[toys$company == "AKZO", "company"] <- "akzo"
toys[toys$company == "akz0", "company"] <- "akzo"
toys[toys$company == "ak zo", "company"] <- "akzo"

toys[toys$company == "Van Houten", "company"] <- "van houten"
toys[toys$company == "van Houten", "company"] <- "van houten"

toys[toys$company == "unilver", "company"] <- "unilever"
toys[toys$company == "Unilever", "company"] <- "unilever"



toys <- toys %>% separate(Product.code...number, into = c("product_code", "product_name"), sep = "-")


toys <- toys %>%  mutate(product_category = ifelse(product_code == "p", "Smartphone", ifelse(product_code == "v" ,"TV", ifelse(product_code == "x", "Laptop", ifelse(product_code == "q", "Tablet", "other")))))



toys <- toys %>% mutate(full_address = paste(address,city,country, sep = "," ))

toys

toys <- toys %>% 
  mutate(vars = 1) %>% 
  spread(company, vars, fill = 0, sep = "_") %>% 
  left_join(toys) 

toys <-toys %>% 
  mutate(vars = 1) %>% 
  spread(product_category, vars, fill = 0, sep = "_") %>% 
  left_join(toys)
toys
write.csv(toys, file = "refine_clean.csv")

