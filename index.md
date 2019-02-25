---
layout: workshop      # NO CAMBIAR ESTO 
carpentry: "swc"    # qué tipo de Carpentry (ya sea "lc", "dc" o "swc")
workshoptitle: "Introducción a R y Git"
venue: "Berkeley Institute for Data Science"        # nombre breve del espacio donde se lleva adelante el taller, sin dirección (por ejemplo, "Universidad de Buenos Aires")
address: 190 Doe Library, Berkeley, California 94720      # dirección completa del espacio donde se realizará el taller (por ejemplo, "Aula 3, Av. Córdoba 1234, Buenos Aires, Argentina")
country: "USA"      # código ISO del país, dos letras en minúscula como por ejemplo "fr" (ver https://en.wikipedia.org/wiki/ISO_3166-1)
language: "es"     # código ISO del idioma, dos letras en minúscula como por ejemplo "fr" (ver https://en.wikipedia.org/wiki/ISO_639-1)
latlng: "37.872495, -122.259556"       # latitud y longitud del espacio en formato decimal (por ejemplo, "41.7901128,-87.6007318" - usar http://www.latlong.net/)
humandate: "8 marzo, 2019"   # fechas del taller en formato legible (por ejemplo, "Feb 17-18, 2020")
humantime: "9:00am - 1:00pm PST"   # hora del taller en formato legible (por ejemplo, "9:00 am - 4:30 pm")
startdate: 2019-03-08      # fecha de inicio del taller en formato YYYY-MM-DD (por ejemplo, 2015-01-01)
enddate: 2019-03-08         # fecha de finalización del taller en formato YYYY-MM-DD, por ejemplo 2015-01-02
instructor: ["Juan Pablo Carvallo", "Hector Miguel Sanchez Castellanos"] # lista de nombres de las instructoras separados por comas y entre corchetes, como ["Hedy Lamarr", "Ada Lovelace", "Madame Curie"]
#helper: ["COMPLETAR"]     # lista de nombres de las **helpers** separados por comas y entre corchetes, como ["Carrie Fisher", "Frances Allen", "Margaret Hamilton"]
email: ["vnvasquez@berkeley.edu"]    # lista de direcciones de correo electrónico de contacto con la **host** ó **lead instructor**, separadas por comas y entre corchetes, como ["ada.lovelace@ejemplo.org", "carrie.fisher@ejemplo.org", "hedy.lamarr@example.org"]
collaborative_notes:             # optional: URL de las notas colaborativas del taller, por ejemplo un Etherpad o documento de Google Docs 
eventbrite: 57139564977    # optional: clave alfanumérica de registro en Eventbrite, por ejemplo "1234567890AB" (si se está utilizando Eventbrite)
---

{% comment %} Ver en los comentarios que siguen las instrucciones sobre cómo editar secciones específicas de esta plantilla de taller {% endcomment %}

{% comment %}
  ENCABEZADO

  Edita los valores en el bloque de arriba para tu taller.
  Si el valor no es 'true', 'false', 'null', o un número, por favor usa
  comillas dobles alrededor del valor, salvo que se especifique de otro modo.
  Por último ejecuta 'make workshop-check' *antes* de comitear para asegurarte que los cambios estan bien.
{% endcomment %}

{% comment %}
  EVENTBRITE
 Es requisito registrarse para participar en este workshop. Por favor reserva su puesto aquí:   
  
{% endcomment %}
{% if page.eventbrite %}
<h2> Registración
<h4>Es requisito registrarse para participar en este workshop. Por favor reserva su puesto aquí: 
<iframe
  src="https://www.eventbrite.com/tickets-external?eid={{page.eventbrite}}&ref=etckt"
  frameborder="0"
  width="100%"
  height="248px"
  scrolling="auto">
</iframe>
{% endif %}



<h4>Esta es la plantilla de taller. Elimina éstas líneas y utilíza la plantilla para personalizar tu propio sitio web. Si estás desarrollando un taller auto-gestionado o aún no hiciste una solicitud de pedido de taller, por favor completa este <a href="{{site.amy_site}}/submit">formulario</a> para notificarnos y que nuestra administradora pueda contactarte si necesitamos información adicional.</h4>



<h2 id="general">Información General</h2>

{% comment %}
  INTRODUCCIÓN 

  Edita el párrafo introductorio general debajo si quieres modificar la presentación.
  
{% endcomment %}
{% if page.carpentry == "swc" %}
  {% include sc/intro.html %}
{% elsif page.carpentry == "dc" %}
  {% include dc/intro.html %}
{% elsif page.carpentry == "lc" %}
  {% include lc/intro.html %}
{% endif %}

{% comment %}
  PÚBLICO

  Explica quién es tu público. (En particular, cuenta a los lectores si el taller esta abierto sólo a personas de una institución o grupo en particular).
  {% endcomment %}
{% if page.carpentry == "swc" %}
  {% include sc/who.html %}
{% elsif page.carpentry == "dc" %}
  {% include dc/who.html %}
{% elsif page.carpentry == "lc" %}
  {% include lc/who.html %}
{% endif %}

{% comment %}
  UBICACIÓN

  Este bloque muestra la dirección y enlaces a mapas con instrucciones para llegar, si la latitud y longitud fueron definidas. Puedes utilizar http://itouchmap.com/latlong.html para encontrar la lat/long de una dirección. 
{% endcomment %}
{% if page.latlng %}
<p id="where">
  <strong>Dónde:</strong>
  {{page.address}}.
  Obtener direcciones con:
  <a href="//www.openstreetmap.org/?mlat={{page.latlng | replace:',','&mlon='}}&zoom=16">OpenStreetMap</a>
  o
  <a href="//maps.google.com/maps?q={{page.latlng}}">Google Maps</a>.
</p>
{% endif %}

{% comment %}
  FECHA

  Este bloque muestra la fecha y enlaces a Google Calendar.
{% endcomment %}
{% if page.humandate %}
<p id="when">
  <strong>Cuándo:</strong>
  {{page.humandate}}.
  {% include workshop_calendar.html %}
</p>
{% endif %}

{% comment %}
  REQUERIMIENTOS ESPECIALES
  
  Modifica este bloque si hay algún requerimiento especial.
{% endcomment %}
<p id="requirements">
  <strong>Requerimientos:</strong> Las asistentes deben traer una computadora portátil con sistema operativo Mac, Linux o Windows (no tablet, Chromebook, etc.), que tenga permisos de administradora habilitados. Deben tener algunos paquetes de software específicos instalados (listados <a href="#setup">aquí</a>). 
	
También es requerido que respeten el 
  {% if page.carpentry == "swc" %}
  Software Carpentry's
  {% elsif page.carpentry == "dc" %}
  Data Carpentry's
  {% elsif page.carpentry == "lc" %}
  Library Carpentry's
  {% endif %}
  <a href="{{site.swc_site}}/conduct.html">Código de Conducta</a>. 
</p>


{% comment %}
  ACCESIBILIDAD

  Modifica este bloque si existen barreras de accesibilidad o instrucciones especiales.
{% endcomment %}
<p id="accessibility">
  <strong>Accesibilidad:</strong> Estamos comprometidas a hacer que este taller sea accesible para todas. Las organizadoras comprobaron que: 
</p>
<ul>
  <li>El salón es accesible para silla de ruedas o similar</li>
  <li>Baños accesibles a disposición</li>
</ul>
<p>
  Los materiales se entregaran antes del taller, también se encuentra disponible material impreso si se pide a los organizadores con anticipación. Si podemos ayudar a facilitar el aprendizaje (por ejemplo, con intérpretes de lenguaje de señas, o instalaciones para lactancia) por favor contáctanos (utilizando los detalles de contacto listados debajo) e intentaremos proveerlos.
</p>

{% comment %}
  DIRECCIONES DE CORREO ELECTRÓNICO DE CONTACTO

  Muestra los correos electrónicos de contacto definidos en el archivo de configuración.
{% endcomment %}
<p id="contact">
  <strong>Contacto</strong>:
  Por favor escribe a
  {% if page.email %}
    {% for email in page.email %}
      {% if forloop.last and page.email.size > 1 %}
        o
      {% else %}
        {% unless forloop.first %}
        ,
        {% endunless %}
      {% endif %}
      <a href='mailto:{{email}}'>{{email}}</a>
    {% endfor %}
  {% else %}
    a ser anunciado
  {% endif %}
  para más información.
</p>

<hr/>

{% comment %}
  SCHEDULE



 Muestra el cronograma del taller. Edita los ítems y horarios en la tabla para ajustarlos a tu planificación. Puede que quieras modificar 'Día 1' y 'Día 2' para mostrar fechas concretas o días de la semana.

{% endcomment %}
<h2 id="schedule">Cronograma</h2>

{% comment %} NO EDITAR LOS ENLACES A LAS ENCUESTAS {% endcomment %}
<p><em>Encuestas</em></p>
{% if page.carpentry == "swc" %}
<p>Por favor, asegúrese de completar estas encuestas antes y después del taller.</p>
<p><a href="{{ site.swc_pre_survey }}{{ site.github.project_title }}">Encuesta pre-taller</a></p>
<p><a href="{{ site.swc_post_survey }}{{ site.github.project_title }}">Encuesta post-taller</a></p>

{% elsif page.carpentry == "dc" %}
  <p>Por favor, asegúrese de completar estas encuestas antes y después del taller.</p>
<p><a href="{{ site.dc_pre_survey }}{{ site.github.project_title }}">Pre-workshop Survey</a></p>
<p><a href="{{ site.dc_post_survey }}{{ site.github.project_title }}">Post-workshop Survey</a></p>
{% elsif page.carpentry == "lc" %}
<p>Pregúntele a su instructor acerca de los detalles de la encuesta antes y después del taller.</p>
{% endif %}


{% if page.carpentry == "swc" %}
  {% include sc/schedule.html %}
{% elsif page.carpentry == "dc" %}
  {% include dc/schedule.html %}
{% elsif page.carpentry == "lc" %}
  {% include lc/schedule.html %}
{% endif %}

{% comment %}
  Notas de colaboración

  Si quieres usar un Etherpad, ve a

      http://pad.software-carpentry.org/YYYY-MM-DD-site

  donde 'YYYY-MM-DD-site' es el identificador de su taller,
  e.g., '2015-06-10-esu'.
{% endcomment %}
{% if page.collaborative_notes %}
<p id="collaborative_notes">
 Utilizaremos este <a href="{{page.collaborative_notes}}"> documento colaborativo </a> para chatear, tomar notas y compartir URL y fragmentos de código.
</p>
{% endif %}

<hr/>

{% comment %}
  CURRICULA

  En inglés, syllabus. Muestra que tópicos van a ser cubiertos.

  1. Si tu taller es sobre R antes que Python, remueve el comentario
     alrededor de esa sección y pon un comentario alrededor de la sección Python.
  2. Algunos talleres van a remover SQL.
  3. Por favor asegúrate que la lista de tópicos está sincronizada con lo que
     pretendes enseñar.
  4. Podría ser que necesites mover los campos div con class="col-md-6" alrededor
     dentro de los div con class="row" para balancear el diseño multi-columnar.

  Este es uno de los lugares donde la gente frecuentemente comete errores, así que
  por favor observa la previsualización del sitio antes de comitear, y asegúrate
  de ejecutar también 'tools/check'.
{% endcomment %}
<h2 id="syllabus">Currícula</h2>

{% if page.carpentry == "swc" %}
  {% include sc/syllabus.html %}
{% elsif page.carpentry == "dc" %}
  {% include dc/syllabus.html %}
{% elsif page.carpentry == "lc" %}
  {% include lc/syllabus.html %}
{% endif %}

<hr/>

{% comment %}
  CONFIGURACIÓN
 
  Borra las secciones irrelevantes de las instrucciones de configuración. Cada sección esta dentro de un 'div' que no contiene clases para que el comienzo y el final sean más fáciles de encontrar.
  Este es otro lugar en donde las personas cometen errores de forma más frecuente, por favor previsualiza tu sitio antes de commitear y además asegurate de ejecutar 'tools/check'.
  
{% endcomment %}

<h2 id="setup">Configuración</h2>

<p>
  Para participar en un taller de
  {% if page.carpentry == "swc" %}
  Software Carpentry
  {% elsif page.carpentry == "dc" %}
  Data Carpentry
  {% elsif page.carpentry == "lc" %}
  Library Carpentry
  {% endif %}
  ,
  necesitarás acceso a algunos de los programas descritos abajo.
  Además, necesitarás un navegador actualizado.
</p>
<p>
  Mantenemos una lista de problemas comunes que ocurren durante la instalación como referencia para los instructores que pueden ser útiles en la 
  <a href = "{{site.swc_github}}/workshop-template/wiki/Configuration-Problems-and-Solutions">Configuration Problems and Solutions wiki page</a>.
</p>


<div id="r"> {% comment %} Start of 'R' section. {% endcomment %}
  <h3>R</h3>

  <p>
    <a href="http://www.r-project.org">R</a> es un lenguaje de programación 
    especialmente poderoso para exploración de datos, visualización y  
    análisis estadístico. Para trabajar con R, usamos
    <a href="http://www.rstudio.com/">RStudio</a>.
  </p>

  <div class="row">
    <div class="col-md-4">
      <h4 id="r-windows">Windows</h4>
      <a href="https://www.youtube.com/watch?v=q0PjTAylwoU">Video Tutorial en inglés </a>
      <p>



        Instala R descargando e instalando
        <a href="http://cran.r-project.org/bin/windows/base/release.htm">este archivo .exe </a>
        desde <a href="http://cran.r-project.org/index.html">CRAN</a>.
        Además, instala el entorno de desarrollo integrado, en inglés Integrated Development Environment (IDE) 
        <a href="http://www.rstudio.com/ide/download/desktop">RStudio</a>.
        Ten en cuenta que si tienes cuentas separadas de usuario y administrador,
	debes correr los instaladores como administrador (haz click derecho en el 
        archivo .exe y selecciona "Ejecutar como administrador" en lugar de hacer doble click)  
        De lo contrario pueden ocurrir problemas, por ejemplo, cuando instales paquetes de R.


      </p>
    </div>
    <div class="col-md-4">
      <h4 id="r-macosx">macOS</h4>
      <a href="https://www.youtube.com/watch?v=5-ly3kyxwEg">Video Tutorial en inglés</a>
      <p>
        Instala R descargando e instalando
        <a href="http://cran.r-project.org/bin/macosx/R-latest.pkg">este archivo .pkg </a>
        desde <a href="http://cran.r-project.org/index.html">CRAN</a>.
        Además, instala el entorno de desarrollo integrado, en inglés Integrated Development Environment (IDE) 
        <a href="http://www.rstudio.com/ide/download/desktop">RStudio</a>.
      </p>
    </div>
    <div class="col-md-4">
      <h4 id="r-linux">Linux</h4>
      <p>
        Puedes descargar los archivos binarios para tu distribución
        desde <a href="http://cran.r-project.org/index.html">CRAN</a>. O
        puedes usar tu administrador de paquetes (por ejemplo: para Debian/Ubuntu
        corre <code>sudo apt-get install r-base</code> y para Fedora corre
        <code>sudo dnf install R</code>).  Además, por favor instala el entorno de desarrollo integrado, 
	en inglés Integrated Development Environment (IDE) 
        <a href="http://www.rstudio.com/ide/download/desktop">RStudio</a>.
      </p>
    </div>
  </div>
</div> {% comment %} End of 'R' section. {% endcomment %}


<div id="git"> {% comment %} Start of 'Git' section. La compatibilidad de GitHub  
           esta en https://help.github.com/articles/supported-browsers/{% endcomment %}
  <h3>Git</h3>

  <p>
    Git es un sistema de versión de control que permite hacer un seguimiento de
    quien hiso que cambios, donde y cuando, tiene la opción de actualizar fácilmente
    una versión publica o compartida de tu codigo en <a href="https://github.com/">github.com</a>.
    Vas a neesitar un navegador web
    <a href="https://help.github.com/articles/supported-browsers/">soportado</a>
    (actualmente Chrome, Firefox, Safari, o Internet Explorer 9 para arriba)
  </p>
  <p>
    Vas a necesitar una cuenta en <a href="https://github.com/">github.com</a>
    para alguna partes de la lección de Git. Las cuentas basicas en GitHub son gratuitas.
    Te incentivamos a crear una cuenta en GitHub si todavia no tenes una.
    Por favor considera que información persional te gustaria hacer publica.
    Por  ejemplo, por ahi te gustaria revisar algunas de estas
    <a href="https://help.github.com/articles/keeping-your-email-address-private/">instrucciones
    para mantener tu dirección de email privada</a> escrita por GitHub.
  </p>

  <div class="row">
    <div class="col-md-4">
      <h4 id="git-windows">Windows</h4>
      <p>
        Git deberia estar instalado en tu computadora como parte
        de tu instalacion de Bash (escrito mas abajo).
      </p>
    </div>
    <div class="col-md-4">
      <h4 id="git-macosx">macOS</h4>
      <a href="https://www.youtube.com/watch?v=9LQhwETCdwY ">Video Tutorial</a>
      <p>
        <strong>Para OS X 10.9 y superiores</strong>, instala Git para Mac
        ejecutando el instalador mas reciente de "mavericks", podes descargarlo
        <a href="http://sourceforge.net/projects/git-osx-installer/files/">de esta lista</a>.
        Después de instalar Git, no vas a ver nada en tu carpeta <code>/Applications</code> por que
        Git es un programa de linea de comando.
        <strong>Para versiónes mas antiguas de OS X (10.5-10.8)</strong>
        Usa el instalador <a href="http://sourceforge.net/projects/git-osx-installer/files/"> disponible </a>
        mas reciente de "snow-leopard".
      </p>
    </div>
    <div class="col-md-4">
      <h4 id="git-linux">Linux</h4>
      <p>
        Si Git no esta ya en tu maquina podes tratar de instalarlo a través
        de los repositorios de tu distribución. Para Debian/Ubuntu ejecuta
        <code>sudo apt-get install git</code> y para Fedora
        <code>sudo dnf install git</code>
      </p>
    </div>
  </div>
</div> {% comment %} End of 'Git' section. {% endcomment %}







