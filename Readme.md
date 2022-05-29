# P2_Probstat_C_5025201202

|     NRP    |     Nama    |
| :--------- |:--------    |
| 5025201202 | Aiffah Kiysa Waafi |

## 1. 
<p style="color: green">
Seorang peneliti melakukan penelitian mengenai pengaruh aktivitas 𝐴 terhadap kadar saturasi oksigen pada manusia. Peneliti tersebut mengambil sampel sebanyak 9 responden. Pertama, sebelum melakukan aktivitas 𝐴, peneliti mencatat kadar saturasi oksigen dari 9 responden tersebut. Kemudian, 9 responden tersebut diminta melakukan aktivitas 𝐴. Setelah 15 menit, peneliti tersebut mencatat kembali kadar saturasi oksigen dari 9 responden tersebut. Berikut data dari 9 responden mengenai kadar saturasi oksigen sebelum dan sesudah melakukan aktivitas 𝐴
</p>

![tabel1](img/tabel1.png)

Data tabel diatas kita simpan dalam bentuk csv agar mudah digunakan, kemudian dilakukan pencarian standar deviasi dan nilai uji t-test.
```
data <- read.csv("saturasi_oksigen.csv")
data
```

### a. Carilah Standar Deviasi dari data selisih pasangan pengamatan tabel diatas
```
sd(data$ï..X-data$Y)
```
![1a](img/1a.png)

Didapatkan standar deviasi sebesar 6.359595

### b. carilah nilai t (p-value)
```
t.test(data$Y, data$ï..X, paired=TRUE)
```
![1b](img/1b.png)

Dari hasil t-test didapatkan t = 7.6525, derajat bebas (df) = 8, dan p-value = 6.003e-05.

### c. tentukanlah apakah terdapat pengaruh yang signifikan secara statistika dalam hal kadar saturasi oksigen , sebelum dan sesudah melakukan aktivitas 𝐴 jika diketahui tingkat signifikansi 𝛼 = 5% serta H0 : “tidak ada pengaruh yang signifikan secara statistika dalam hal kadar saturasi oksigen , sebelum dan sesudah melakukan aktivitas 𝐴”

Karena nilai probabilitas (p-value) lebih kecil dibandingkan tingkat signifikansi 𝛼=0,05, maka null hypotesis ditolak dan alternative hypotesis diterima. Hal ini berarti terdapat pengaruh yang signifikan secara statistika dalam hal jumlah kadar saturasi oksigen sebelum dan sesudah melakukan aktivitas A.


## 2.
- Null hypotesis / H0 = miu <= 20.000
- Alternative hypotesis / H1 = miu > 20.000
Karena n >= 30 maka menggunakan uji Z-distribution. Terlebih dahulu install package BSDA dengan cara install.packages(“BSDA”). Kemudian diketahui mean = 23500, standar deviasi = 3900, mu = 20000 dan n = 100. Hipotesis yang diuji adalah satu arah maka menggunakan syntaks seperti berikut 

```
zsum.test(mean.x=23500, sigma.x = 3900, n.x = 100,  
          alternative = "greater", mu = 20000,
          conf.level = 0.95)
```
![2](img/2.png)

### a. Apakah Anda setuju dengan klaim tersebut? 
Ya, setuju
### b. Jelaskan maksud dari output yang dihasilkan!
Dari hasil diatas didapatkan z = 8.97, p-value < 2.2e-16 atau p-value = p(z > 8.97) = 1-p(z < 8.97) = 0. Maka null hypotesis salah.
### c. Buatlah kesimpulan berdasarkan P-Value yang dihasilkan!
Kesimpulan bahwa mobil dikemudikan rata-rata lebih dari 20000 km/tahun benar.


## 3.
![tabel2](img/tabel2.png)

### a. H0 dan H1
- H0 = tidak terdapat perbedaan antara rata-rata saham bandung dengan rata-rata saham bali
- H1 = terdapat perbedaan antara rata-rata saham bandung dengan rata-rata saham bali

### b. Hitung Sampel Statistik
```
tsum.test(mean.x=3.64, s.x = 1.67, n.x = 19, 
          mean.y=2.79, s.y = 1.32, n.y = 27, alternative = "greater", 
          mu = 0, var.equal = TRUE,
          conf.level = 0.90)
```
![3b](img/3b.png)

### c. Lakukan Uji Statistik (df =2)
```
install.packages("mosaic")
library(mosaic)
plotDist(dist='t', df=2, col="red")
```
![3c](img/3c.png)

### d. Nilai Kritikal
```
qchisq(p = 0.05, df = 2, lower.tail=FALSE)
```
![3d](img/3d.png)

### e. Keputusan
Dari hasil t-test didapatkan p-value = 0.03024, berada dibawah 0.05. Maka null hypotesis / H0 ditolak.

### f. Kesimpulan
Kesimpulannya terdapat perbedaan antara rata-rata saham bandung dengan rata-rata saham bali.


## 4.
Diketahui dataset https://intip.in/datasetprobstat1
H0 : Tidak ada perbedaan panjang antara ketiga spesies atau rata-rata panjangnya sama

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

Kemudian menggambarkan plot kuantil normal untuk tiap grup seperti berikut
```
qqnorm(Group1$Length)
qqline(Group1$Length)

qqnorm(Group2$Length)
qqline(Group2$Length)

qqnorm(Group3$Length)
qqline(Group3$Length)
```
![4a](img/4a.1.png) ![4a1](img/4a.2.png) ![4a2](img/4a.3.png)

### b. carilah atau periksalah Homogeneity of variances nya, Berapa nilai p yang didapatkan? , Apa hipotesis dan kesimpulan yang dapat diambil ?
Untuk memeriksa homogenitas varians dilakukan seperti berikut
```
bartlett.test(Length ~ Group, data = onewayanova)
```
![4b](img/4b.png)

Didapatkan p-value sebesar 0.8054, p-value berada diatas 0.05 yang artinya varians dari ketiga kelompok sama dan kesimpulannya terdapat homogenitas varians untuk melakukan anova satu arah (one way).

### c. Untuk uji ANOVA (satu arah), buatlah model linier dengan Panjang versus Grup dan beri nama model tersebut model 1.
```
model1 = lm(Length ~ Group, data = onewayanova)
anova(model1)
```
![4c](img/4c.png)

### d. Dari Hasil Poin C, Berapakah nilai-p?, Apa yang dapat Anda simpulkan dari H0?
Didapatkan nilai F-value = 7.0982, yang berarti nilai P-value lebih kecil dari 0.05. Kesimpulannya kita menolak null hypotesis / H0, maka menunjukkan adanya perbedaan panjang antara ketiga spesies atau rata-rata panjangnya sama.

### e. Verifikasilah jawaban model 1 dengan Post-hoc test Tukey HSD, dari nilai p yang didapatkan apakah satu jenis kucing lebih panjang dari yang lain? Jelaskan.
Dilakukan Post-hoc test Tukey HSD untuk mengetahui perbandingan tiap-tiap spesies
```
TukeyHSD(aov(model1))
```
![4e](img/4e.png)

Dari hasil diatas dapat diketahui p-value tiap 2 jenis grup. Jika p-value lebih kecil dari 0.05, maka panjang kedua grup berbeda, jika p-value lebih dari 0.05 maka panjangnya sama. Berdasarkan hasil diatas dapat disimpulkan kucing putih dan kucing oren memiliki ukuran atau panjang yang sama.

### f. Visualisasikan data dengan ggplot2
```
ggplot(onewayanova, aes(x = Group, y = Length)) +
  geom_boxplot(color = c("#00AFBB", "#E7B800", "#FC4E07")) +
  scale_x_discrete() + xlab("Group") + ylab("Length (cm)")
```
![4f](img/4f.png)



## 5.
Percobaan dilakukan sebanyak 27 kali dan didapat data sebagai berikut: https://drive.google.com/file/d/1aLUOdw_LVJq6VQrQEkuQhZ8FW43FemTJ/view.

Langkah pertama yaitu mengimport data dari GTL.csv dan mengecek struktur dari data seperti berikut
```
glasstemp = read.csv("GTL.csv")
glasstemp
# check structure
str(glasstemp)
```

### a. Buatlah plot sederhana untuk visualisasi data
```
qplot(x = Temp, y = Light, geom = "auto", data = glasstemp) +
  facet_grid(.~Glass, labeller = label_both)
```
![5a](img/5a.png)

Dapat dilihat bahwa cahaya pada glass A dan B meningkat seiring dengan meningkatnya suhu, sedangkan pada glass C maksimum berada pada 125 C.

### b. Lakukan uji ANOVA dua arah
```
glasstemp$Glass <- as.factor(glasstemp$Glass)
glasstemp$Temp <- as.factor(glasstemp$Temp)


anova <- aov(Light ~ Glass*Temp, data = glasstemp)
summary(anova)
```
![5b](img/5b.png)

### c. Tampilkan tabel dengan mean dan standar deviasi keluaran cahaya untuk setiap perlakuan (kombinasi kaca pelat muka dan suhu operasi)
```
summary <- group_by(glasstemp, Glass, Temp) %>%
  summarise(mean=mean(Light), sd=sd(Light)) %>%
  arrange(desc(mean))
summary
```
![5c](img/5c.png)

### d. Lakukan uji Tukey
```
tukeyGlass <- TukeyHSD(anova)
print(tukeyGlass)
```
![5d](img/5d.png)

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
![5e](img/5e.png)

