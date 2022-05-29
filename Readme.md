# 1.

Data tabel diatas kita simpan dalam bentuk csv agar mudah digunakan, kemudian dilakukan pencarian standar deviasi dan nilai uji t-test.
```
data <- read.csv("saturasi_oksigen.csv")
data
```

### a. Carilah Standar Deviasi dari data selisih pasangan pengamatan tabel diatas
```
sd(data$ï..X-data$Y)
```

didapatkan standar deviasi sebesar 6.359595

### b. carilah nilai t (p-value)
```
t.test(data$Y, data$ï..X, paired=TRUE)
```

dari hasil t-test didapatkan t = 7.6525, derajat bebas (df) = 8, dan p-value = 6.003e-05.

### c. tentukanlah apakah terdapat pengaruh yang signifikan secara statistika dalam hal kadar saturasi oksigen , sebelum dan sesudah melakukan aktivitas 𝐴 jika diketahui tingkat signifikansi 𝛼 = 5% serta H0 : “tidak ada pengaruh yang signifikan secara statistika dalam hal kadar saturasi oksigen , sebelum dan sesudah melakukan aktivitas 𝐴”

Karena nilai probabilitas (p-value) lebih kecil dibandingkan tingkat signifikansi 𝛼=0,05, maka null hypotesis ditolak dan alternative hypotesis diterima. Hal ini berarti terdapat pengaruh yang signifikan secara statistika dalam hal jumlah kadar saturasi oksigen sebelum dan sesudah melakukan aktivitas A.

# 2.
null hypotesis / H0 = miu <= 20.000
alternative hypotesis / H1 = miu > 20.000

Karena n >= 30 maka menggunakan uji Z-distribution. Terlebih dahulu install package BSDA dengan cara install.packages(“BSDA”). Kemudian diketahui mean = 23500, standar deviasi = 3900, mu = 20000 dan n = 100. Hipotesis yang diuji adalah satu arah maka menggunakan syntaks seperti berikut 

```
zsum.test(mean.x=23500, sigma.x = 3900, n.x = 100,  
          alternative = "greater", mu = 20000,
          conf.level = 0.95)
```

### a. Apakah Anda setuju dengan klaim tersebut? 
Ya, setuju
### b. Jelaskan maksud dari output yang dihasilkan!
    Dari hasil diatas didapatkan z = 8.97, p-value < 2.2e-16 atau p-value = p(z > 8.97) = 1-p(z < 8.97) = 0. Maka null hypotesis salah.
### c. Buatlah kesimpulan berdasarkan P-Value yang dihasilkan!
Kesimpulan bahwa mobil dikemudikan rata-rata lebih dari 20000 km/tahun benar.


# 3.
### a. H0 dan H1

### b. Hitung Sampel Statistik
tsum.test(mean.x=3.64, s.x = 1.67, n.x = 19, 
          mean.y=2.79, s.y = 1.32, n.y = 27, alternative = "greater", 
          mu = 0, var.equal = TRUE,
          conf.level = 0.90)

### c. Lakukan Uji Statistik (df =2)
install.packages("mosaic")
library(mosaic)
plotDist(dist='t', df=2, col="red")

### d. Nilai Kritikal
qchisq(p = 0.05, df = 2, lower.tail=FALSE)

### e. Keputusan

### f. Kesimpulan

# 4.
```
onewayanova = read.table("onewayanova.txt",h=T)
onewayanova
```
### a. Buatlah masing masing jenis spesies menjadi 3 subjek "Grup" (grup 1,grup2,grup 3). Lalu Gambarkan plot kuantil normal untuk setiap kelompok dan lihat apakah ada outlier utama dalam homogenitas varians.
Karena setiap grup nya berdistribusi normal maka tidak ada outlier utama. Untuk membuat grup tiap jenis nya, bisa menggunakan factor kemudian memberikan label dan subset setiap grup. Group1 adalah kucing oren, Group2 adalah kucing hitam dan Group3 adalah kucing putih.
```
# set group jadi factor
onewayanova$Group <- as.factor(onewayanova$Group)

# memberikan label
onewayanova$Group = factor(onewayanova$Group,labels = c("kucing oren", "kucing hitam", "kucing putih"))

Group1 <- subset(onewayanova, Group == "kucing oren")
Group2 <- subset(onewayanova, Group == "kucing hitam")
Group3 <- subset(onewayanova, Group == "kucing putih")
```

kemudian menggambarkan plot kuantil normal untuk tiap grup seperti berikut
```
qqnorm(Group1$Length)
qqline(Group1$Length)

qqnorm(Group2$Length)
qqline(Group2$Length)

qqnorm(Group3$Length)
qqline(Group3$Length)
```

### b. carilah atau periksalah Homogeneity of variances nya, Berapa nilai p yang didapatkan? , Apa hipotesis dan kesimpulan yang dapat diambil ?

Untuk memeriksa homogenitas varians dilakukan seperti berikut
```
bartlett.test(Length ~ Group, data = onewayanova)
```

Didapatkan p-value sebesar 0.8054, p-value berada diatas 0.05 yang artinya varians dari ketiga kelompok sama dan kesimpulannya terdapat homogenitas varians untuk melakukan anova satu arah (one way).

### c. Untuk uji ANOVA (satu arah), buatlah model linier dengan Panjang versus Grup dan beri nama model tersebut model 1.
```
model1 = lm(Length ~ Group, data = onewayanova)
anova(model1)
```

### d. Dari Hasil Poin C, Berapakah nilai-p?, Apa yang dapat Anda simpulkan dari H0?
Didapatkan nilai F-value = 7.0982, yang berarti nilai P-value lebih kecil dari 0.05. Kesimpulannya kita menolak null hypotesis / H0, maka menunjukkan adanya perbedaan panjang antara ketiga spesies atau rata-rata panjangnya sama.

### e. Verifikasilah jawaban model 1 dengan Post-hoc test Tukey HSD, dari nilai p yang didapatkan apakah satu jenis kucing lebih panjang dari yang lain? Jelaskan.
Dilakukan Post-hoc test Tukey HSD untuk mengetahui perbandingan tiap-tiap spesies
```
TukeyHSD(aov(model1))
```

Dari hasil diatas dapat diketahui p-value tiap 2 jenis grup. Jika p-value lebih kecil dari 0.05, maka panjang kedua grup berbeda, jika p-value lebih dari 0.05 maka panjangnya sama. Berdasarkan hasil diatas dapat disimpulkan kucing putih dan kucing oren memiliki ukuran atau panjang yang sama.

### f. Visualisasikan data dengan ggplot2
```
ggplot(onewayanova, aes(x = Group, y = Length)) +
  geom_boxplot(color = c("#00AFBB", "#E7B800", "#FC4E07")) +
  scale_x_discrete() + xlab("Group") + ylab("Length (cm)")
```

# 5.

### a. Buatlah plot sederhana untuk visualisasi data
```
qplot(x = Temp, y = Light, geom = "auto", data = glasstemp) +
  facet_grid(.~Glass, labeller = label_both)
```

### b. Lakukan uji ANOVA dua arah
```
glasstemp$Glass <- as.factor(glasstemp$Glass)
glasstemp$Temp <- as.factor(glasstemp$Temp)


anova <- aov(Light ~ Glass*Temp, data = glasstemp)
summary(anova)
```

### c. Tampilkan tabel dengan mean dan standar deviasi keluaran cahaya untuk setiap perlakuan (kombinasi kaca pelat muka dan suhu operasi)
```
summary <- group_by(glasstemp, Glass, Temp) %>%
  summarise(mean=mean(Light), sd=sd(Light)) %>%
  arrange(desc(mean))
summary
```
### d. Lakukan uji Tukey
```
tukeyGlass <- TukeyHSD(anova)
print(tukeyGlass)
```

### e. Gunakan compact letter display untuk menunjukkan perbedaan signifikan antara uji Anova dan uji Tukey
```
# membuat compact letter display
install.packages("multcompView")
library(multcompView)
tukey.cld <- multcompLetters4(anova, tukey)
print(tukey.cld)

# menambahkan means dan sd ke tabel compact letter display
cld <- as.data.frame.list(tukey.cld$`Glass:Temp_Factor`)
summary$Tukey <- cld$Letters
print(summary)
```


