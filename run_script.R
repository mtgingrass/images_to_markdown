# Load necessary libraries
library(glue)
library(fs)
library(purrr)

# Set the directory containing the images
image_dir <- "images/"
output_file <- "index.qmd"

# Validate if the image directory exists
if (!dir_exists(image_dir)) {
  stop(glue("Directory '{image_dir}' does not exist. Please check the path."))
}

# List all image files in the directory, including .webp
image_files <- dir_ls(image_dir, regexp = "\\.(jpg|jpeg|png|gif|webp)$")

# Handle the case where no images are found
if (length(image_files) == 0) {
  stop(glue("No image files found in '{image_dir}'. Please add some images."))
}

# Select the first image as the featured image
featured_image <- image_files[1]  
featured_image_path <- glue("{featured_image}")  # Ensuring correct formatting

# Create a Markdown content generator function
generate_markdown <- function(image_path) {
  image_name <- path_file(image_path)  # Extract the file name
  base_name <- path_ext_remove(image_name)  # Remove file extension
  
  # Generate Markdown content for each image
  glue("
## {base_name}

![{base_name}]({image_path})

")
}

# Generate Markdown for all images
markdown_content <- map_chr(image_files, generate_markdown)

# Add Quarto metadata with featured image
metadata <- c(
  "---",
  "title: 'My Photo Blog Post'",
  "author: 'Your Name'",
  glue("date: '{Sys.Date()}'"),  # Dynamic date
  "categories: ['Photography', 'Hiking']",
  glue("image: '{featured_image_path}'"),  # Featured image
  "format: html",
  "---\n\n"
)

# Combine metadata and Markdown content
final_post <- paste0(paste(metadata, collapse = "\n"), "\n", paste(markdown_content, collapse = "\n"))

# Write the Markdown content to a Quarto file
writeLines(final_post, output_file)

message("Markdown post generated successfully at: ", output_file)