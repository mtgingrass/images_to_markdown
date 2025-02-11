# 📸 Photo Blog Generator

This project dynamically generates a **Quarto blog post** from images in the `images/` folder. You can easily change it to a .Rmd or .md file as well.

## 📌 How It Works
1. Add your images to the `images/` folder. (I left my images in the folder, replace them with your own images)
2. Edit the glue function if you do not want to have headings or the filename displayed.

Change these lines:

```{r}
 glue("
## {base_name}
![{base_name}]({image_path})
")
```

To this:

```{r}
 glue("
![]({image_path})
")
```
3. Run the script in R:
   ```r
   source("run_script.R")
   ```
   
4. Open the index.qmd file.