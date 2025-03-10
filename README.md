# Calico-Godot-Game-Project
gierka
Silnik: Godot Engine v4.3

9 grudnia 2024r.:
Projekt jest w bardzo wczesnej fazie - dopiero co powstał. Wrzucony został initial commit do etapu 1. obecnego taska, projekt spełnia naprawdę podstawowe założenia tego etapu - jest to praktycznie szkielet, na którym wraz z feedbackami i kolejnymi pracami nad nim będzie dostosowywany i będzie nabierał kształtu.
Jedyna placeholderowa tekstura to tekstura postaci w res://assets - druga jest obecnie nieużywana.

10 marca 2025r.:
Nastąpiło kilka updateów projektu, oto ich krótkie podsumowanie, a poniżej nieco bardziej szczegółowa dokumentacja obecnego stanu projektu:
 - dodano podstawę systemu interakcji - po wejściu do strefy interakcji i naciśnięciu dedykowanego przycisku, gra wykonuje odpowiednie działania - w jednym z przypadków jest to przeniesienie gracza do poziomu 2D - nowej sceny
 - rozpoczęto pracę nad przykładowym poziomem (level_test_2D), dodano defaultowy movement postaci (potem nieco usprawniony, by był nieco lepszy do kontrolowania), oraz dodano odbijanie się od głowy przeciwnika
 - w tym tygodniu (6-10 marca) rozpoczęto pracę nad projektem poziomu, wg wrzuconego na discordzie schematu poziomu tutorialowego, w tym celu utworzono przykładowy tileset oraz utworzono tymczasowy parallax background.
Stan projektu na dzisiaj:
 - Focus na level_test_2D
 - W projekcie poziomu wykorzystano TileMapLayer z tymczasowym tilesetem, grid 16x16 pikseli. W tilesecie znajdują się też platformy, które posiadają nieco inny hitbox - zostało to uwzględnione
 - Rozmiar postaci zbliżony do formatu 16x32 piksele, hitbox nieco zwęższony (12x32 piksele)
 - Utworzony został początek poziomu tutorialowego, zawierający dwie pierwsze sekcje platformowe
 - Istnieje stacjonarny (na razie ukryty) przeciwnik, od którego można się odbić, skacząc mu na głowę
Ewentualne kwestie dotyczące szczegółowości raportu (głównie dane techniczne - rozmiary pikseli, dokładna charakterystyka ruchu postaci i SI przeciwników, dokładny plan mapy) zostawię do uzgodnienia - na tym etapie nie sądzę, by to było jeszcze aż tak koniecznie, ale jestem otwarty na propozycje dot. komunikacji i współpracy nad projektem żeby nic się nie rozjechało
