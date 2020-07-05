#### process data
data = read.csv("data_CRISP_eGFR.csv")
## compute age at visit
bday = as.Date(data[,2], tryFormats = c("%m/%d/%Y"))
vday = as.Date(data[,3], tryFormats = c("%m/%d/%Y"))
age_vday = as.numeric(difftime(vday, bday, units="days")/365)

## remake data
data = data.frame(data, vday=vday, bday=bday, age_vday=age_vday)
## remove NA entries
data = data[!is.na(data$ckd_epi),]

## do Spaghetti plot
require(ggplot2)
id = as.factor(data$pkdid)
basecols = c("black", "blue", "red", "green")
basecol = sample(basecols, nlevels(id), replace=TRUE)
levels(id) = basecol
cols = as.character(id)

pdf("eGFR_age.pdf", width=7, height=5)
ggplot(data = data, aes(x = age_vday, y = ckd_epi, group = pkdid)) +
    xlab("Age") + ylab("eGFR") +
    geom_line(aes(color=cols))	+
    geom_point(color=1, size=0.5) +
    theme(legend.position="none")
dev.off()


##### use the date
ggplot(data = data, aes(x = vday, y = ckd_epi, group = pkdid)) +
    xlab("Visit date") + ylab("eGFR") +
    geom_line(aes(color=cols))  +
    geom_point(color=1, size=0.5) +
    theme(legend.position="none")

##### Redesign colors, to make them according to different age
### First find age at the first visit for all IDs
library(RColorBrewer)
age1 = aggregate(age_vday~pkdid, data=data, FUN=min)
## categorize ages
ncate = 5
ii = seq(floor(min(age1[,2])), ceiling(max(age1[,2])), length=ncate+1)
tmp = cut(age1[,2], ii)
basecolor = tmp
col0 = brewer.pal(ncate,"Spectral")
col0 = 1:5
names(col0) = levels(tmp)
levels(basecolor) = col0

## create colors
names(basecolor) = age1[,1]
cols = basecolor[as.character(data[,1])]


ggplot(data = data, aes(x = vday, y = ckd_epi, group = pkdid)) +
    xlab("Visit date") + ylab("eGFR") +
    geom_line(color=cols) +
    geom_point(color=1, size=0.5) +
    scale_colour_manual(values = col0)





############## draw in a loop
xlims = range(data$vday)
ylims = range(data$ckd_epi, na.rm=T)

age1 = aggregate(age_vday~pkdid, data=data, FUN=min)
ncate = 5
ii = round(seq(floor(min(age1[,2])), ceiling(max(age1[,2])), length=ncate+1))
tmp = cut(age1[,2], ii)
basecolor = tmp
col0 = brewer.pal(ncate,"Spectral")
col0 = 1:5
names(col0) = levels(tmp)
levels(basecolor) = col0
names(basecolor) = age1[,1]

pdf("eGFR_Vist_age.pdf", width=12, height=8)
mypar(1,1)
plot(data$vday, data$ckd_epi, xlim=xlims, ylim=ylims, type="n", xlab="Visit date", ylab="eGFR")
allID = unique(data$pkdid)
for (i in 1:length(allID)) {
    ix = data$pkdid == allID[i]
    data0 = data[ix,]
    ix2 = sort.int(data0$vday, index.return=TRUE)$ix
    data0 = data0[ix2,]
    lines(data0$vday, data0$ckd_epi, type="b", pch=19, cex=0.5, lwd=1.5,
         col=basecolor[as.character(allID[i])])
}
legend("topright", legend=names(col0), col=col0, lty=1, title="Age category", ncol=2, lwd=2)
dev.off()
