tabItem(
  tabName = "tab_procurement_incoming_goods",
  fluidRow(
    box(
      title = "Shiny-ERP Procurement - Produktzugang PZU",
      width = 12,
      solidHeader = TRUE,
      status = "primary",
      fluidRow(
        column(
          6,
          align = "center",
          selectInput('resource_1002', "Select resource", choices = c())
          
        ),
        column(
          6,
          align = "center",
          sliderInput("quantity_1002", label = "Select Quantity", min = 1,max = 10, value = 1)
        )
      ),
      fluidRow(column(
        6,
        align = "center",
        selectInput('agent_ext_1002', "Select external Agent", choices = c())
      )),
      fluidRow(column(
        6,
        align = "center",
        selectInput('agent_int_1002', "Select internal Agent", choices = c())
      )),
      fluidRow(column(
        3,
        align = "left",
        actionButton("actionButton_1002", "Commit to Database")
      ))
    )
  )
)