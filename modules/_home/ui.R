tabItem(tabName = "tab_home",
        fluidRow(
          div(img(
            src = 'shiny-erp.png', align = "center", width = "450"
          ), style = "text-align: center;"),
          h3("Shiny-ERP"),
          h3("A REA-compliant ERP-Prototpye for Slottie AG"),
          #h3("Candle Manufacturing Inc. Shiny-ERP"),
          #h3("Decision Support System"),
          p("Technische Universität Wien"),
          p(
            tags$a(href = "https://www.imw.tuwien.ac.at/fc/", "Financial Enterprise Management Group, 2019")
          ),
          p(
            tags$a(href = "mailto:christian.fischer-pauzenberger@tuwien.ac.at", "Christian Fischer-Pauzenberger")
          ),
          p("Walter S.A. Schwaiger")
        ))