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
    )
    
)
)