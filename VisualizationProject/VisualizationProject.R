# install.packages(c("shiny", "bio3d", "rgl"))

# Load required libraries
library(shiny)
library(bio3d)
library(rgl)

# Define UI for application
ui <- fluidPage(
  titlePanel("PDB 3D Structure Viewer"),
  sidebarLayout(
    sidebarPanel(
      textInput("pdb_id", "Enter PDB ID:", value = "1CRN"),
      #In the value region is where we insert the PBD ID
      #For example, i inserted a PBD ID of 1CRN as an example PBD ID of a specific Protein
      actionButton("submit", "Submit")
    ),
    mainPanel(
      rglwidgetOutput("structure")
    )
  )
)

# Define server logic in order to visualize the protein structure
server <- function(input, output) {
  # Reactive expression to create 3D plot
  output$structure <- renderRglwidget({
    pdb_id <- input$pdb_id
    pdb_file <- get.pdb(pdb_id, split = TRUE)
    
    # Open 3D device
    open3d()
    
    # Plot 3D structure
    plot3d(pdb_file, type = "stick", col = "lightblue", size = 2, main = paste("3D Structure of", pdb_id))
    
    # Close 3D device
    rglwidget()
  })
}

#Runs application and the PDB visualization will be downloaded into the this projects files
shinyApp(ui=ui, server=server)