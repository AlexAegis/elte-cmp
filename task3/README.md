# Prepare an environment
I recommending using Ubuntu or Windows 10's Ubuntu subsystem (you can get it for free from the Microsoft Store)

As root:
´´´
apt-get update
apt-get upgrade
apt-get install flex
apt-get install bisonc++
apt-get install g++

´´´
# Tools
Regex Tester: https://regex101.com/

# Usage
´´´bash
flex abaps.l
g++ -oabaps abaps.cc lex.yy.cc
./abaps test.abaps
´´´
####To run the freshest version:
´´´bash
flex abaps.l | g++ -oabaps abaps.cc lex.yy.cc | ./abaps test.abaps
´´´
*Határidők: közel kész megoldás: március 2\. (péntek) éjfél, javítások: március 9\. (péntek) éjfél
*Az ajánlott fejlesztőkörnyezet a `pandora.inf.elte.hu` szerver.
*Tesztfájlok [letölthetőek](http://deva.web.elte.hu/fordprog/abap2018-tesztfajlok.zip "http://deva.web.elte.hu/fordprog/abap2018-tesztfajlok.zip")!
*Feladat: lexikális elemző elkészítése [ehhez a nyelvhez](/pubwiki/doku.php?id=fordprog:abap2018 "fordprog:abap2018")
*flex segítségével (segítség főleg estiseknek: [Flex tutorial](http://deva.web.elte.hu/fordprog/flex-tutorial.pdf "http://deva.web.elte.hu/fordprog/flex-tutorial.pdf"))
*a programnak parancssori paraméterben lehessen megadni az elemzendő fájl nevét
*a program minden felismert lexikális elemhez egy sort írjon a képernyőre, például
*`kulcsszo: IF`
*`nyito zarojel`
*`valtozo: b`
*…
*Lexikális hiba észlelése esetén hibajelzést kell adni, ami tartalmazza a hiba sorának számát; ezután a program befejeződhet, nem kell folytatni az elemzést.
*Ebből a [példaprogramból érdemes kiindulni](http://deva.web.elte.hu/fordprog/lexikalis-pelda.zip "http://deva.web.elte.hu/fordprog/lexikalis-pelda.zip")
*A beadandó két fájlból álljon, egy flex és egy c++ forrásfájlból. (Generált fájlokat tilos beadni.)
*Az elemzőprogram visszatérési értéke lexikálisan helyes program esetén nulla, egyébként nullától különböző legyen! Ezt figyeli az automatikus tesztelő!
*Beadás módja: [Ezen az oldalon](https://bead.inf.elte.hu/ "https://bead.inf.elte.hu/") az INF-es felhasználónévvel és jelszóval kell belépni, majd jelentkezni a saját gyakorlatvezetőhöz fordítóprogramok tárgyból. A megoldást a beadandókezelőben olvasható formátumban kell beküldeni.
*Automatikus ellenőrzés: Figyelem! Ehhez a beadandóhoz is lesz automatikus tesztelés, azaz a beküldés után néhány perccel látni fogjátok az eredményt, de ezt a gyakorlatvezető felülbírálhatja. (Ennek oka, hogy erre a feladatra könnyű olyan megoldást beküldeni, ami a teszteken átmegy, de teljesen használhatatlan lesz, amikor a 2\. beadandót próbáljátok ráépíteni.)