

# graphics


# a graphics device is a place where you can plot things.
# RStudio has a built-in graphics device, 
# but there are others. On a mac, we have the quartz() device
# windows has the windows() device
# linux has x11()

# typing quartz() opens a quartz graphics device
# (you'll need to type windows() or x11() if not on a mac)
# it's possible to set a default graphics device
# to be different from the RStudio one 
# (we won't cover that here)

quartz()
# windows()
# x11()

# if we make a plot, it will go into the most recently 
# opened device
plot(0)

# there is a family of functions dev.*() for controlling 
# the graphics deivce we will use dev.off() in this session
dev.off()   # closes most recent device
plot(0)
dev.list()  # lists the open graphical devices
quartz()
dev.list()
dev.cur()
graphics.off()  # closes all of them


# the graphics device has a set of graphical parameters
# that can be viewed as set with the par() function
par()
?par

# plot.new() opens up a graphics device with an empty plot
plot.new()

# plot() can be used to put things in the plot window
# if no device is open, it opens a new graphics device, 
# otherwise, it puts the plot in the most recently 
# opened device
plot(1:10,10:1)
# this uses all of the defaults for everything

# but we can change anything we want
par(font=5,col="magenta",ann=FALSE,bg="gray")
plot(1:10,10:1)

# some aspects of the plot can be set within the plot() 
# function but sometimes they take on different meanings, 
# so be careful
dev.off()   # close current graphics device (resets par())
plot(1:10,10:1,cex=2,col="magenta",xlab="predictor",
    ylab="response",main="Our Data",asp = 1)
# note that the behavior of 'col' is not the same, 
# as when we used par() actually the behavior 
# of cex is different inside of par() too


# some other things we can change
plot(1:10,10:1,cex=4,pch=16,type="o",ylim=c(0,11),lwd=3)
plot(1:10,10:1,axes=FALSE,type="l",pch="P",
     xlab=expression(sqrt(pi)))

# we can also create an empty plot and build it up how we like
plot(1:10,10:1,type="n",axes=FALSE,ann=FALSE,
     xlim=c(0,10),ylim=c(0,10))
points(1:10,10:1,pch=4)  # add points to the current plot
axis(1,at = seq(0,10,by=2) )
mtext("x values",side = 1,line=0)
axis(2,at = seq(0,10,by=2), labels = seq(0,10,by=2)^2 )
mtext("y values",side = 2,line=3)
box()   # this looks bad! (look at the horizontal axis)

# the double line on the axes really bothers me
plot(1:10,10:1,type="n",axes=FALSE,ann=FALSE,
     xlim=c(0,10),ylim=c(0,10))
points(1:10,10:1,pch=4)
axis(1,at = seq(0,10,by=2), lwd = 0 ,lwd.ticks = 1 )
mtext("x values",side = 1,line=0)
axis(2,at = seq(0,10,by=2), labels = seq(0,10,by=2)^2, 
     lwd = 0 ,lwd.ticks = 1 )
mtext("y values",side = 2,line=3)
box()   # beautiful


# sometimes we want to add a legend to the plot
plot(rep(1:5,2),rep(1:5,2)+rep(c(0,4),each=5),
     pch=c(rep(0,5),rep(1,5)),ylim=c(0,12))
legend(x=1,y=10,c("Raleigh","Durham"),pch=c(1,0),
       text.width=0.55)


# adding annotations to plots can also be done with the text() function
plot(rep(1:5,2),rep(1:5,2)+rep(c(0,4),each=5),
     pch=c(rep(0,5),rep(1,5)),ylim=c(0,12))
points(c(1.2,1.2),c(9,10),pch=c(0,1))
text(1.2,9,"Durham",pos=4)
text(1.2,10,"Raleigh",pos=4)
rect(1,8.2,2,10.8)


# setting setting margins can be frustrating, especially when 
# working with several plots within the same graphics device

par(oma=c(2, 2, 2, 2), mar=c(4, 4, 2, 2))
set.seed(1)
plot(rnorm(10), xlab="x label", ylab="y label")
box("outer", col="red", lwd=2)
mtext("device region", side=3, line=1, col="red", outer=TRUE)
box("inner", col="green")
mtext("figure region", side=3, line=1, col="green")
box("plot", col="blue")
text(5, 0, "plot region", col="blue")
# if you make the mar too small it can push the labels out,
# which makes them invisible


# for publications, it's often bet to make the outer margin 
# zero to minimize wasted space on the page
# this is especially true when you have multiple plots 
# on the same figure
par(oma=c(0,0,0,0), mar=c(4, 4, 2, 2))
set.seed(1)
plot(rnorm(10), xlab="x label", ylab="y label")
box("outer", col="red", lwd=2)
mtext("device region", side=3, line=1, col="red", outer=TRUE)
box("inner", col="green")
mtext("figure region", side=3, line=1, col="green")
box("plot", col="blue")
text(5, 0, "plot region", col="blue")



# we can automatically set up grids of plots with the 
# mfrow tag
par(mfrow=c(2,3),oma=c(0,0,0,0))  # 2x3 grid of plots
for(j in 1:6) plot(0,type="n",main=paste("Position",j))

# mfcol plots them in column major ordering
par(mfcol=c(2,3),oma=c(0,0,0,0))  # 2x3 grid of plots 
for(j in 1:6) plot(0,type="n",main=paste("Position",j))

# if we make a new plot it will cycle back to the 
# first and replace it
plot(0,type="n",main="Replaced Plot")


# we can also use the fig tag to have precise control of the plot locations
par(fig=c(0.4,1,0.2,1))
plot(1:10,10:1)
par(fig=c(0,0.4,0,0.8),new=TRUE)  # when adding a plot, set new = TRUE
plot(1:10,10:1)


# plots can be created as above and then be saved by 
# clicking on export >> save as image or save as pdf
# however, for figures that will go in publications, 
# you should really use the postscript() or pdf() 
# graphics devices to save the figures this makes 
# it much easier to change figures after reviewers 
# ask for changes

# postscript and pdf create vector graphics, as 
# opposed to pixel-based graphics. Vectors graphics 
# usually look much better in pdfs because they are 
# not resolution-dependent

# opens pdf device with default settings
pdf(file="figure01.pdf")    
plot(1:10,10:1) # notice that nothings happens in the R device
dev.off()       # shut down the device to save it
# now there is a file figure01.pdf in your directory



# I prefer to use postscript so I can use 
# plain latex and psfrag in my latex documents
postscript(file="figure01.eps")
plot(1:10,10:1)
dev.off()

# there are all sorts of options to be set
postscript(file="figure01.eps",
           family = "Times", width=6,height=4)
plot(1:10,10:1)
dev.off()


# from the postscript() documentation
# The postscript produced for a single R plot is EPS 
# (Encapsulated PostScript) compatible, and can be 
# included into other documents, e.g., into LaTeX, 
# using \includegraphics{<filename>}. For use in 
# this way you will probably want to use setEPS() 
# to set the defaults as horizontal = FALSE, 
# onefile = FALSE, paper = "special". 
postscript(file="figure01.eps",family = "Times", 
    width=6,height=4, horizontal=FALSE,paper="special")
plot(1:10,10:1)
dev.off()



