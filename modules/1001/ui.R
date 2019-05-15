tabItem(
  tabName = "tab_forecasting",
  fluidRow(
    
    box(
      title = "Show Data",
      width = 12,
      solidHeader = TRUE,
      status = "primary",
      fluidRow(column(
        12,
        align = "center",
        actionButton("actionButton_1001", "Show Sales Data")
      ))
    ),
    box(
      title = "Table",
      width = 12,
      align = "center",
      status = "primary",
      solidHeader = TRUE,
      collapsible = TRUE,
      collapsed = FALSE,
      dataTableOutput('dataTableOutput_1001')
    ),
    box(
      title = "Foreacast",
      width = 12,
      align = "center",
      status = "primary",
      solidHeader = TRUE,
      collapsible = FALSE,
      collapsed = FALSE,
      fluidRow(column(
        12,
        align = "center",
        actionButton("actionButtont1_1001", "1 Year"),
        actionButton("actionButtont2_1001", "3 Years"),
        actionButton("actionButtont3_1001", "5 Years")
      )
      ),
      fluidRow(
        column(
          12,
          align = "center",
          sliderInput("Confidence", label = "Confidence", min = 0,max = 100, value = c(75, 95))
        )
      ),
      plotOutput('plotOutput_1001')
    )
)
)