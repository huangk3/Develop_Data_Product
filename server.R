library(shiny)
library(ggplot2)
library(datasets)

mpgData<-mtcars[, c('mpg', 'cyl', 'am', 'wt')]
mpgData<-transform(mpgData, cyl=as.factor(cyl), am=as.factor(am))
fitmodel<-lm(mpg~cyl+am+wt+am:wt, data=mpgData)

shinyServer(function(input, output) {   
op<-reactive({predict(fitmodel, newdata=data.frame(cyl=as.factor(as.numeric(input$cyl)), am=as.factor(as.numeric(input$am)), 
                     wt=as.numeric(input$wt)/1000), interval="confidence")})
# op<-reactive({predict(fitmodel, newdata=data.frame(cyl=as.numeric(input$cyl), am=as.numeric(input$am), 
#                       wt=as.numeric(input$wt)/1000), interval="confidence")})  

output$p_mpg<-renderText({round(op()[1], 2)})
output$ci<-renderText({paste('[', round(op()[2], 2),"--", round(op()[3],2),']')})

output$plot_mpg_wt<-renderPlot({ggplot(data=mpgData, aes_string(x='wt', y='mpg', colour=input$tp))+
                                  geom_point()+geom_smooth(method='lm', se=T)+xlab("Weight/1000lb")+
                                  ylab("Mile Per Gallon")+ggtitle("MPG v.s. weight in the database")})
})


