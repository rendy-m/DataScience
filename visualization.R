# obtain the stocks data and filter it by date
ProcterGamble <- getSymbols("PG",return.class="data.frame",from="2021-01-01")
ProcterGamble <- PG%>%
  mutate(Date=as.Date(row.names(.)))%>%
  select(Date,PG.Close)%>%
  rename(Close=PG.Close)%>%
  mutate(Company="P&G")

Johnson <- getSymbols("JNJ",return.class="data.frame",from="2021-01-01")
Johnson <- JNJ %>%
  mutate(Date=as.Date(row.names(.)))%>%
  select(Date,JNJ.Close)%>%
  rename(Close= JNJ.Close)%>%
  mutate(Company="Johnson&Johnson")

# Let's bind these two time series together
Time_series <- rbind(ProcterGamble, Johnson)

# After binding it into a dataframe, here's how you can visualize it:
ggplot(Time_series, 
       aes(x=Date, y= Close, color=Company)) + 
  geom_line(size=1.5) + geom_smooth() +
  scale_y_continuous(labels = scales::dollar)+
  scale_x_date(date_breaks = '1 month',labels = date_format("%b-%y")) +
  labs(title = "S&P 500 Stocks",subtitle="Health sectors vs Consumer Staples Stocks",y="Close Price") +
  theme_minimal()
