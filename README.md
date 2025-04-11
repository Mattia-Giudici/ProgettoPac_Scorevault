# ScoreVault - Iterazione 1

## Panoramica del Progetto

In questa iterazione, si procede con la creazione del progetto Flutter definendo la struttura di base coerente con il design pattern scelto nell'iterazione precedente. L'applicazione ScoreVault è progettata per gestire partite e punteggi di giochi da tavolo, facilitando l'interazione sociale tra giocatori attraverso un'interfaccia intuitiva e coinvolgente.

## Struttura Tecnologica

### Pacchetti Fondamentali (da pub.dev)

| Pacchetto | Descrizione | Funzionalità |
|-----------|-------------|--------------|
| **Provider** | Gestione dello stato | Implementazione del pattern Provider per la gestione centralizzata dello stato dell'applicazione |
| **Firebase_core** | Connessione a Firebase | Funzionalità base per l'integrazione con Firebase |
| **Firebase_auth** | Autenticazione | API per gestire l'autenticazione degli utenti tramite Firebase Auth |
| **Firebase_firestore** | Database NoSQL | API per il salvataggio e recupero dei dati su Firebase Firestore |
| **Firebase_storage** | Storage system | API per gestire lo storage di file su Firebase |

### Pacchetti Aggiuntivi

- **json_annotation** e **json_serializable**: Supporto per la serializzazione/deserializzazione di oggetti JSON
- **Google_fonts**: Integrazione dei font di Google per migliorare l'aspetto dell'interfaccia utente
- **build_runner**: Generazione di codice automatizzata
- **change_app_package_name**: Modifica del nome del pacchetto dell'applicazione

## Casi d'Uso Implementati

### UC1: Gestione Utente (astratto)

#### UC1.1: SignIn

**Descrizione**:  
Quando l'utente avvia l'applicazione, viene presentata una schermata di benvenuto con due opzioni prominenti: "Accedi" e "Registrati". Toccando il pulsante "Accedi", l'utente viene indirizzato a una schermata di login. Questa schermata contiene due campi di input chiaramente etichettati: uno per l'email e uno per la password (con caratteri nascosti), insieme a un pulsante "Accedi" nella parte inferiore. Nella parte superiore della schermata è presente il logo dell'app ScoreVault.

**Attori**:  
- Utente
- Firebase Auth

**Trigger**:  
- L'utente tocca il pulsante "Accedi" sulla schermata di benvenuto
- L'utente tenta di accedere a una sezione protetta dell'app mentre non è autenticato, in tal caso viene automaticamente reindirizzato alla schermata di login
- L'utente avvia l'app dopo aver effettuato il logout nell'ultima sessione

**Procedimento**:  
1. L'utente inserisce il proprio indirizzo email nel primo campo. Durante la digitazione, l'app verifica in tempo reale il formato dell'email, mostrando un messaggio di errore se il formato non è valido.
2. L'utente inserisce la propria password nel secondo campo, un pulsante con una precisa icona, indica se la password è visibile durante la digitazione
3. L'utente tocca il pulsante "Accedi" per avviare il processo di autenticazione.
5. Appare un indicatore di caricamento che sostituisce temporaneamente il pulsante "Accedi".
6. Se l'autenticazione fallisce, appare un messaggio di errore in rosso sotto i campi di input, specificando se il problema è relativo all'email o alla password.
7. Se l'autenticazione ha successo, l'app mostra una breve animazione di transizione e l'utente viene reindirizzato alla schermata principale.

#### UC1.2: SignUp

**Descrizione**:  
Dalla schermata di benvenuto, l'utente può toccare il pulsante "Registrati" per accedere alla schermata di registrazione. Questa schermata presenta un'interfaccia molto simile a quella di login, ma con un due campi di testo ulteriori, rispettivamente per il nome utente e per la conferma della password.

**Attori**:  
- Utente
- Firebase Auth
  
**Trigger**:  
- L'utente tocca il pulsante "Registrati" nella schermata di benvenuto
- L'utente seleziona "Non hai un account? Registrati ora" nella schermata di login

**Post-condizione**:  
Dopo una corretta registrazione dell'account, l'accesso all'applicazione avviene in automatico. La schermata principale dell'app si apre.

**Procedimento**:  
1. L'utente inserisce l'email desiderata nel primo campo. 
2. L'utente crea e conferma la password nei campi successivi.
3. L'utente inserisce un Username
4. L'utente tocca il pulsante "Completa registrazione" nella parte inferiore della schermata.
5. L'app mostra un indicatore di caricamento mentre crea l'account in Firebase Auth, configura il documento utente in Firestore.
6. Una volta completato il processo,avviene l'autenticazione automatica e l'app mostra la schermata home

#### UC1.3: SignOut

**Descrizione**:  
La funzionalità di logout è accessibile dalla schermata del profilo utente. Nella parte superiore della schermata del profilo, l'utente visualizza un pulsante con la dicitura "Disconnetti"

**Attori**:  
- Utente
- Firebase Auth

**Trigger**:  
- L'utente tocca il pulsante "Disconnetti" nella schermata del profilo
- L'utente seleziona "Disconnetti" dal menu a hamburger (se disponibile nell'interfaccia)
- Il sistema rileva un'anomalia di sicurezza e forza il logout (raro)

**Post-condizione**:  
Dopo la pressione del pulsante, l'applicazione reindirizza automaticamente l'utente alla schermata di login

**Procedimento**:  
1. L'utente naviga alla schermata del profilo toccando l'icona "Profilo" nella barra superiore.
2. L'utente scorre verso il basso fino alla fine della pagina del profilo dove trova il pulsante "Disconnetti".
3. L'utente tocca il pulsante "Disconnetti", che si illumina leggermente al tocco per fornire feedback visivo.
4. Appare un dialogo modale di conferma al centro dello schermo, con un'ombreggiatura semi-trasparente che oscura il resto dell'interfaccia.
5. Se l'utente tocca "Annulla", il dialogo si chiude e l'utente rimane nella schermata del profilo.
6. Se l'utente tocca "Conferma", l'app inizia il processo di logout, mostrando brevemente un indicatore di caricamento circolare.
7. L'app cancella i token di autenticazione, termina la sessione con Firebase e cancella i dati sensibili dalla memoria locale.
8. L'app reindirizza l'utente alla schermata di benvenuto con un effetto di transizione fluido.

#### UC1.4: Visualizza informazioni utente loggato

**Descrizione**:  
La schermata del profilo utente è accessibile toccando l'icona "Profilo" (rappresentata da una silhouette umana o l'immagine di profilo) nell'angolo destro della barra di navigazione inferiore. Questa schermata presenta un design moderno con la foto profilo dell'utente in formato circolare nella parte superiore, seguita immediatamente dal nome utente in caratteri grandi e ben visibili. Sotto queste informazioni primarie, è presente un pulsante "Amici" seguito da un contatore dove visualizzarne rapidamente il numero.
In basso è presente il tasto "Disconnetti"

**Attori**:  
- Utente
- Firebase Auth
- Firebase Firestore
- Firebase Storage


**Trigger**:  
- L'utente tocca l'icona "Profilo" nella barra di navigazione inferiore

**Post-condizione**:  
L'utente visualizza tutte le proprie informazioni personali in un'unica schermata scorrevole, organizzata in sezioni logiche e visivamente distinte. I dati mostrati sono aggiornati in tempo reale, quindi eventuali modifiche recenti (come nuove richieste di amicizia o risultati di partite) sono immediatamente visibili. Se l'utente ha ricevuto nuove richieste di amicizia, un badge numerato rosso appare accanto alla "Campanella" nella parte superiore della appBar. 

**Procedimento**:  
1. L'utente accede alla schermata principale dell'app dopo il login.
2. L'utente tocca l'icona "Profilo" nell'angolo destro della barra di navigazione inferiore.
3. L'app recupera i dati del profilo utente da Firestore, attraverso uno Stream.
4. L'app permette all'utente di navigare verso la sezione "Amici"

#### UC1.5: Cerca utenti e richiesta di amicizia

**Descrizione**:  
La funzionalità di ricerca utenti è accessibile dalla schermata del profilo, presenta una lista di tutti gli account presenti nell'applicazione, tranne il proprio e gli account che sono già 

**Attori**:  
- Utente
- Firebase Firestore

**Trigger**:  
- L'utente tocca l'icona di aggiunta amici nella schermata "Amici"
- L'utente inserisce un codice di invito ricevuto da un altro utente

**Post-condizione**:  
Dopo aver inviato una richiesta di amicizia, l'interfaccia utente nella homepage, mostrerà una notifica di richiesta di amiciza.
La richiesta mostrerà un banner con le informazioni dell'utente che ha fatto richiesta di diventare amico, con le opzioni per accettare o declinare.

**Procedimento**:  
1. L'utente naviga alla schermata "Amici" attraverso il profilo.
2. L'utente tocca l'icona di aggiunta amico nell'angolo superiore destro della schermata.
3. Si apre la schermata di ricerca con il campo di input per il codice amico
4. L'utente digita il codice amico e preme il pulsante di invio richiesta.

#### UC1.5: Aggiungi amici

**Descrizione**:  
La schermata "Aggiungi amici" è accessibile toccando il **Floating Action Button (FAB)** con icona “+” o simile, visibile in basso a destra nella schermata "Amici". Questa schermata ha un design pulito e moderno e consente all’utente di cercare altri account tramite una **barra di ricerca** situata nella parte superiore, che accetta input sia per **nome utente** che per **email**.  
I risultati vengono mostrati come **schede utente**, ognuna delle quali presenta la **foto profilo** (in formato circolare), il **nome utente**, e un pulsante **"Invia richiesta di amicizia"**.  
Se la richiesta è stata già inviata o l’utente è già amico, il pulsante sarà disabilitato o mostrerà uno stato alternativo (es. "Richiesta inviata").

**Attori**:  
- Utente  
- Firebase Auth  
- Firebase Firestore  

**Trigger**:  
- L'utente tocca il FAB "+" nella schermata "Amici"

**Post-condizione**:  
L’utente può inviare richieste di amicizia ad altri utenti. Le richieste inviate vengono salvate su Firestore e riflettono immediatamente lo stato aggiornato grazie a meccanismi in tempo reale (Stream). La UI mostra visivamente lo stato della richiesta per ogni utente.

**Procedimento**:  
1. L’utente si trova nella schermata "Amici".  
2. Tocca il FAB posizionato in basso a destra per accedere alla schermata "Aggiungi amici".  
3. L’app mostra una barra di ricerca in alto.  
4. L’utente inserisce un nome utente o un’email nella barra di ricerca.  
5. L’app effettua una query in tempo reale a Firestore per trovare corrispondenze.  
6. I risultati vengono mostrati come schede ordinate verticalmente.  
7. Ogni scheda ha un pulsante "Invia richiesta di amicizia".  
8. Quando l’utente preme il pulsante, l’app registra la richiesta su Firestore.  
9. Il pulsante cambia stato per indicare che la richiesta è stata inviata.

Perfetto! Ecco il caso d’uso per la schermata **"Notifiche richieste di amicizia"**, mantenendo lo stesso stile coerente:

---

#### UC1.6: Notifiche richieste di amicizia

**Descrizione**:  
La schermata "Notifiche" è accessibile dalla schermata "Profilo utente", toccando l'icona **"Campanella"** posizionata nella parte superiore destra della appBar. Se l’utente ha ricevuto una o più richieste di amicizia non ancora gestite, sulla campanella appare un **badge rosso** con il numero di notifiche pendenti.  
Toccando l’icona, l’utente viene reindirizzato alla schermata "Notifiche", dove viene mostrato un elenco verticale di **schede utente**, ciascuna contenente la **foto profilo**, il **nome utente** del richiedente e due pulsanti di azione: **"Accetta"** (verde) e **"Rifiuta"** (rosso).

**Attori**:  
- Utente  
- Firebase Auth  
- Firebase Firestore  

**Trigger**:  
- L’utente tocca l’icona "Campanella" nella schermata "Profilo utente"

**Post-condizione**:  
L’utente può accettare o rifiutare richieste di amicizia. L’azione viene salvata in Firestore e la lista notifiche si aggiorna in tempo reale. Il badge scompare automaticamente se non ci sono più richieste pendenti.

**Procedimento**:  
1. L’utente si trova nella schermata "Profilo utente".  
2. Visualizza un’icona "Campanella" nella appBar.  
3. Se sono presenti richieste di amicizia in attesa, l’icona mostra un badge rosso con il numero di notifiche.  
4. L’utente tocca l’icona per accedere alla schermata "Notifiche".  
5. L’app recupera da Firestore l’elenco delle richieste di amicizia ricevute.  
6. Ogni richiesta è rappresentata in una scheda utente con:  
   - Foto profilo (circolare)  
   - Nome utente  
   - Pulsante **"Accetta"** (verde)  
   - Pulsante **"Rifiuta"** (rosso)  
7. L’utente può:  
   - Toccare **"Accetta"** per aggiungere il richiedente alla lista amici (modifica su Firestore)  
   - Toccare **"Rifiuta"** per ignorare la richiesta (rimozione/aggiornamento su Firestore)  
8. L’interfaccia si aggiorna in tempo reale: la richiesta scompare dalla lista una volta gestita.

### UC2: Gestione giochi (astratto)

#### UC2.1: Visualizza libreria giochi

**Descrizione**:  
La libreria giochi è accessibile toccando l'icona "Giochi" (rappresentata da un dado o controller di gioco stilizzato) nella barra di navigazione inferiore. Questa schermata presenta una ricca interfaccia visiva con una gridList nella parte superiore, che mostra i giochi con copertine colorate e accattivanti. Sopra il carosello, l'utente trova una barra di ricerca con l'indicazione "Cerca tra i giochi" e icone di filtro. I giochi sono rappresentati da una card, ciascuna con l'immagine di copertina, il titolo del gioco e una piccola icona che indica la categoria (strategia, carte, dadi, ecc.). I giochi preferiti dall'utente sono evidenziati con un simbolo di stella dorata/cuore nell'angolo della card. In alto a destra, un menu a tendina consente di ordinare i giochi per vari criteri: Popolari, Recenti, Alfabetici, o Per categoria. La schermata supporta lo scorrimento infinito, caricando dinamicamente più giochi mentre l'utente scorre verso il basso.

**Attori**:  
- Utente autenticato
- Sistema di database Firestore
- Servizio di cache per le immagini dei giochi

**Trigger**:  
- L'utente tocca l'icona "Giochi" nella barra di navigazione inferiore
- L'utente viene reindirizzato alla libreria dopo una ricerca generale nell'app
- 
**Post-condizione**:  
L'utente visualizza un'ampia selezione di giochi disponibili nel sistema, organizzati in modo intuitivo e visivamente accattivante. I giochi che l'utente ha già giocato o aggiunto ai preferiti sono chiaramente identificabili grazie a indicatori visivi (stella per i preferiti, badge con numero di partite giocate). Se l'utente ha applicato filtri o effettuato ricerche, la libreria mostra solo i giochi corrispondenti ai criteri selezionati, con un'indicazione chiara dei filtri attivi nella parte superiore (ad es. "Mostrando: Giochi di strategia per 2-4 giocatori"). Se non ci sono risultati per una ricerca, appare un messaggio amichevole "Nessun gioco trovato" con suggerimenti alternativi. L'utente può facilmente aggiungere giochi ai preferiti toccando l'icona a forma di cuore su qualsiasi card, che cambia da contorno a pieno con una breve animazione di feedback.

**Procedimento**:  
1. L'utente accede alla schermata principale dell'app dopo il login.
2. L'utente tocca l'icona "Giochi" nella barra di navigazione inferiore.
3. L'app carica inizialmente una vista paginata della libreria, mostrando prima i giochi più popolari o quelli suggeriti per l'utente.
4. Durante il caricamento, vengono visualizzati skeleton loader delle card dei giochi.
5. L'utente può scorrere verticalmente per esplorare la libreria completa.
6. L'utente può scorrere orizzontalmente il carosello superiore per vedere giochi in evidenza.
7. Per filtrare i risultati, l'utente può toccare l'icona del filtro accanto alla barra di ricerca e selezionare vari criteri (numero di giocatori, durata, categoria, ecc.).
8. Per cercare un gioco specifico, l'utente può toccare la barra di ricerca e digitare il nome o parole chiave.
9. Per aggiungere un gioco ai preferiti, l'utente può toccare l'icona a forma di cuore sulla card del gioco.
10. Per visualizzare i dettagli di un gioco, l'utente tocca la card corrispondente.

#### UC2.2: Visualizza dettaglio di un gioco

**Descrizione**:  
La schermata di dettaglio di un gioco si apre quando l'utente tocca una card di gioco dalla libreria o dai risultati di ricerca. Questa schermata presenta un design immersivo con un'immagine di copertina del gioco a tutto schermo nella parte superiore, che sfuma gradualmente verso il contenuto sottostante. Il titolo del gioco appare in caratteri grandi e ben leggibili sopra l'immagine, con un'ombreggiatura che garantisce la leggibilità su qualsiasi sfondo. Sotto l'immagine di copertina, una sezione di "Informazioni rapide" mostra icone e testo per numero di giocatori (es. "2-5"), tempo di gioco (es. "30-45 min"), complessità (es. "★★☆☆☆") e età consigliata (es. "10+"). Scorrendo verso il basso, l'utente trova una descrizione dettagliata del gioco, seguita da sezioni per regole semplificate, sotto la descrizione vediamo i pulsanti di "Statistiche personali" che mostrano quante volte l'utente ha giocato, la sua percentuale di vittorie e i punteggi medi. Nella parte inferiore della schermata, un pulsante "Registra partita" invita all'azione principale.

**Attori**:  
- Utente autenticato
- Sistema di database Firestore
- Servizio di cache per contenuti multimediali

**Trigger**:  
- L'utente tocca una card di gioco nella libreria giochi
- L'utente seleziona un gioco dai risultati di ricerca
- L'utente seleziona un gioco dal suo storico partite
- L'utente clicca su un link di condivisione di un gioco ricevuto da un amico

**Post-condizione**:  
L'utente visualizza tutte le informazioni dettagliate relative al gioco selezionato in un'unica schermata scorrevole, con sezioni chiaramente delimitate. Se l'utente ha già giocato a questo gioco, la sezione "Le tue statistiche" mostra dati personalizzati come numero di partite, vittorie, sconfitte e punteggi medi, insieme a un grafico dell'andamento temporale dei risultati. Se si tratta di un gioco mai giocato dall'utente, questa sezione mostra invece un messaggio "Non hai ancora giocato a questo gioco" con un pulsante "Registra la tua prima partita". Nella parte superiore destra della schermata, icone per "Aggiungi ai preferiti" (cuore) e "Condividi" (simbolo di condivisione) permettono azioni rapide. La navigazione è facilitata da un pulsante "Indietro" nell'angolo superiore sinistro, che riporta alla schermata precedente con un'animazione fluida.

**Procedimento**:  
1. L'utente tocca la card di un gioco nella libreria o nei risultati di ricerca.
2. L'app carica la schermata di dettaglio con una transizione fluida, mostrando inizialmente l'immagine di copertina e il titolo.
4. L'app recupera i dati generali del gioco (descrizione, regole, immagini) e contemporaneamente le statistiche personali dell'utente relative a quel gioco.
5. L'utente può scorrere verticalmente per esplorare tutte le sezioni della schermata.
8. Per registrare una nuova partita di questo gioco, l'utente può toccare il pulsante "Registra partita" nella parte inferiore.
9. Per tornare alla libreria, l'utente tocca il pulsante "Indietro" nell'angolo superiore sinistro.
10. Per aggiungere il gioco ai preferiti, l'utente tocca l'icona a forma di cuore, che cambia stato con un'animazione.

### UC3: Gestione partita (astratto)

**Descrizione**:  
Il modulo di gestione partite è accessibile attraverso l'icona "Partite" (rappresentata da un trofeo o un cronometro) nella barra di navigazione inferiore. Questa schermata principale mostra due tab nella parte superiore: "Le tue partite" e "Partite amici". Nella sezione "Le tue partite", l'utente visualizza uno storico delle proprie partite in ordine cronologico inverso, con card che mostrano il nome del gioco, la data, i partecipanti (rappresentati da avatar circolari) e il risultato sintetizzato (vittoria, sconfitta, posizione o punteggio). Un pulsante circolare blu con icona "+" fluttua nell'angolo inferiore destro della schermata, permettendo di registrare rapidamente una nuova partita da qualsiasi punto della navigazione. Le partite in corso (non ancora concluse) appaiono in cima alla lista con un badge "In corso" e un bordo colorato distintivo. L'interfaccia supporta sia gesti di swipe (per azioni rapide come eliminare o modificare una partita) che tocchi normali per accedere ai dettagli.

**Attori**:  
- Utente
- Firebase Firestore

**Trigger**:  
- L'utente tocca l'icona "Partite" nella barra di navigazione inferiore
- L'utente seleziona "Le mie partite" dal menu del profilo
- L'utente tocca il pulsante "+" fluttuante per creare una nuova partita
- L'utente riceve e apre una notifica relativa a una partita (invito o aggiornamento)

**Post-condizione**:  
L'utente visualizza una lista completa delle proprie partite, organizzata cronologicamente e con indicatori visivi chiari dello stato di ciascuna (completata, in corso, vinta, persa). La navigazione è intuitiva grazie ai tab superiori che permettono di passare facilmente tra le


*Bozze*

+---------------------+       +---------------------+
|     AuthServices    |       |     AuthException   |
+---------------------+       +---------------------+
| + signin()          |       | - code: String      |
| + signup()          |       | - message: String?  |
| + signout()         |       +---------------------+
| + deleteUser()      |               ^
| + forgotPassword()  |               |
| + isLogged()        |               |
| + updateUser()      |       +---------------------+
+---------------------+       |    AuthProvider     |
       ^                      +---------------------+
       |                      | - _firebaseAuth     |
       |                      | - _firestore        |
       |                      | - _cachedUser       |
+---------------------+       +---------------------+
|   ChangeNotifier    |       | + currentFirebaseUser|
+---------------------+       | + currentUser        |
       ^                      | + signin()           |
       |                      | + signup()           |
       |                      | + signout()          |
       |                      | + deleteUser()       |
       |                      | + forgotPassword()   |
       |                      | + isLogged()         |
       |                      | + updateUser()       |
       |                      | - _initializeUser()  |
       |                      | - _fetchAndCacheUser()|
       |                      | - _createUserData()  |
       |                      +---------------------+
       |
+---------------------+
|    ModelUser        |
+---------------------+
| - email: String     |
| - username: String  |
| - friends: List     |
| - pendingFriends: List |
+---------------------+
| + toJson()          |
| + fromJson()        |
| + copyWith()        |
+---------------------+

