.class public final Lcom/finanzas/iglesia/Recordatorios;
.super Ljava/lang/Object;
.source "Recordatorios.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/finanzas/iglesia/Recordatorios$Puente;
    }
.end annotation


# static fields
.field static final ACCION_ALARMA:Ljava/lang/String; = "com.finanzas.iglesia.ALARMA"

.field static final ACCION_POSPONER:Ljava/lang/String; = "com.finanzas.iglesia.POSPONER"

.field static final CANAL:Ljava/lang/String; = "recordatorios_domingo"

.field static final ID_MENSUAL:I = 0x66

.field static final ID_SEMANAL:I = 0x65

.field static final MENSUAL:Ljava/lang/String; = "mensual"

.field static final MESES:[Ljava/lang/String;

.field static final MESES_T:[Ljava/lang/String;

.field static final PREFS:Ljava/lang/String; = "recordatorios"

.field static final SEMANAL:Ljava/lang/String; = "semanal"


# direct methods
.method static constructor <clinit>()V
    .registers 8

    .prologue
    const/4 v7, 0x4

    const/4 v6, 0x3

    const/4 v5, 0x2

    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 36
    const/16 v0, 0xc

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "enero"

    aput-object v1, v0, v3

    const-string v1, "febrero"

    aput-object v1, v0, v4

    const-string v1, "marzo"

    aput-object v1, v0, v5

    const-string v1, "abril"

    aput-object v1, v0, v6

    const-string v1, "mayo"

    aput-object v1, v0, v7

    const/4 v1, 0x5

    const-string v2, "junio"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "julio"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "agosto"

    aput-object v2, v0, v1

    const/16 v1, 0x8

    const-string v2, "septiembre"

    aput-object v2, v0, v1

    const/16 v1, 0x9

    const-string v2, "octubre"

    aput-object v2, v0, v1

    const/16 v1, 0xa

    const-string v2, "noviembre"

    aput-object v2, v0, v1

    const/16 v1, 0xb

    const-string v2, "diciembre"

    aput-object v2, v0, v1

    sput-object v0, Lcom/finanzas/iglesia/Recordatorios;->MESES:[Ljava/lang/String;

    .line 37
    const/16 v0, 0xc

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "Enero"

    aput-object v1, v0, v3

    const-string v1, "Febrero"

    aput-object v1, v0, v4

    const-string v1, "Marzo"

    aput-object v1, v0, v5

    const-string v1, "Abril"

    aput-object v1, v0, v6

    const-string v1, "Mayo"

    aput-object v1, v0, v7

    const/4 v1, 0x5

    const-string v2, "Junio"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "Julio"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "Agosto"

    aput-object v2, v0, v1

    const/16 v1, 0x8

    const-string v2, "Septiembre"

    aput-object v2, v0, v1

    const/16 v1, 0x9

    const-string v2, "Octubre"

    aput-object v2, v0, v1

    const/16 v1, 0xa

    const-string v2, "Noviembre"

    aput-object v2, v0, v1

    const/16 v1, 0xb

    const-string v2, "Diciembre"

    aput-object v2, v0, v1

    sput-object v0, Lcom/finanzas/iglesia/Recordatorios;->MESES_T:[Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .registers 1

    .prologue
    .line 39
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static activo(Landroid/content/Context;Ljava/lang/String;)Z
    .registers 5

    .prologue
    .line 77
    invoke-static {p0}, Lcom/finanzas/iglesia/Recordatorios;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "_on"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method public static conectar(Landroid/app/Activity;Landroid/webkit/WebView;)Ljava/lang/String;
    .registers 8

    new-instance v0, Lcom/finanzas/iglesia/Recordatorios$Puente;
    invoke-virtual {p0}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;
    move-result-object v1
    invoke-direct {v0, v1}, Lcom/finanzas/iglesia/Recordatorios$Puente;-><init>(Landroid/content/Context;)V
    const-string v1, "Recordatorios"
    invoke-virtual {p1, v0, v1}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    :try_start_canal
    invoke-static {p0}, Lcom/finanzas/iglesia/Recordatorios;->crearCanal(Landroid/content/Context;)V
    invoke-static {p0}, Lcom/finanzas/iglesia/Recordatorios;->programar(Landroid/content/Context;)V
    :try_end_canal
    .catch Ljava/lang/Throwable; {:try_start_canal .. :try_end_canal} :canal_listo

    :canal_listo
    const-string v0, "https://appassets.androidplatform.net/index.html"

    :try_start_url
    invoke-virtual {p0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;
    move-result-object v1
    if-eqz v1, :fin

    const-string v2, "abrir"
    invoke-virtual {v1, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v2
    const-string v3, "agregar"
    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v3
    if-nez v3, :abrir_ok
    const-string v3, "reportes"
    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v3
    if-eqz v3, :fin

    :abrir_ok
    new-instance v3, Ljava/lang/StringBuilder;
    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v4, "#abrir="
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v4, "msg"
    invoke-virtual {v1, v4}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v4
    if-eqz v4, :sin_msg
    const-string v5, "&msg="
    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-static {v4}, Landroid/net/Uri;->encode(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v4
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :sin_msg
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0

    const-string v4, "pdf"
    invoke-virtual {v1, v4}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v4
    :try_end_url
    .catch Ljava/lang/Throwable; {:try_start_url .. :try_end_url} :fin

    if-eqz v4, :limpiar
    invoke-virtual {v4}, Ljava/lang/String;->isEmpty()Z
    move-result v5
    if-nez v5, :limpiar

    # Aviso de "Reporte generado" con PDF guardado: abrir el PDF
    :try_start_pdf
    new-instance v5, Landroid/content/Intent;
    const-string v2, "android.intent.action.VIEW"
    invoke-direct {v5, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V
    invoke-static {v4}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;
    move-result-object v4
    const-string v2, "application/pdf"
    invoke-virtual {v5, v4, v2}, Landroid/content/Intent;->setDataAndType(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/Intent;
    const/4 v2, 0x1
    invoke-virtual {v5, v2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;
    invoke-virtual {p0, v5}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V
    :try_end_pdf
    .catch Ljava/lang/Throwable; {:try_start_pdf .. :try_end_pdf} :limpiar

    :limpiar
    :try_start_limpiar
    const-string v2, "pdf"
    invoke-virtual {v1, v2}, Landroid/content/Intent;->removeExtra(Ljava/lang/String;)V
    const-string v2, "msg"
    invoke-virtual {v1, v2}, Landroid/content/Intent;->removeExtra(Ljava/lang/String;)V
    const-string v2, "abrir"
    invoke-virtual {v1, v2}, Landroid/content/Intent;->removeExtra(Ljava/lang/String;)V
    :try_end_limpiar
    .catch Ljava/lang/Throwable; {:try_start_limpiar .. :try_end_limpiar} :fin

    :fin
    return-object v0
.end method

.method static crearCanal(Landroid/content/Context;)V
    .registers 7

    .prologue
    const/4 v5, 0x4

    const/4 v4, 0x1

    .line 57
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-ge v0, v1, :cond_9

    .line 74
    :cond_8
    :goto_8
    return-void

    .line 58
    :cond_9
    const-string v0, "notification"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    .line 59
    const-string v1, "recordatorios_domingo"

    invoke-virtual {v0, v1}, Landroid/app/NotificationManager;->getNotificationChannel(Ljava/lang/String;)Landroid/app/NotificationChannel;

    move-result-object v1

    if-nez v1, :cond_8

    .line 60
    new-instance v1, Landroid/app/NotificationChannel;

    const-string v2, "recordatorios_domingo"

    const-string v3, "Recordatorios de domingo"

    invoke-direct {v1, v2, v3, v5}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V

    .line 61
    const-string v2, "Ofrendas del culto y reporte del mes"

    invoke-virtual {v1, v2}, Landroid/app/NotificationChannel;->setDescription(Ljava/lang/String;)V

    .line 62
    invoke-virtual {v1, v4}, Landroid/app/NotificationChannel;->enableVibration(Z)V

    .line 63
    new-array v2, v5, [J

    fill-array-data v2, :array_5e

    invoke-virtual {v1, v2}, Landroid/app/NotificationChannel;->setVibrationPattern([J)V

    .line 64
    invoke-virtual {v1, v4}, Landroid/app/NotificationChannel;->enableLights(Z)V

    .line 65
    const/4 v2, -0x1

    invoke-virtual {v1, v2}, Landroid/app/NotificationChannel;->setLightColor(I)V

    .line 66
    invoke-virtual {v1, v4}, Landroid/app/NotificationChannel;->setShowBadge(Z)V

    .line 67
    invoke-virtual {v1, v4}, Landroid/app/NotificationChannel;->setLockscreenVisibility(I)V

    .line 68
    const/4 v2, 0x2

    invoke-static {v2}, Landroid/media/RingtoneManager;->getDefaultUri(I)Landroid/net/Uri;

    move-result-object v2

    .line 69
    new-instance v3, Landroid/media/AudioAttributes$Builder;

    invoke-direct {v3}, Landroid/media/AudioAttributes$Builder;-><init>()V

    const/4 v4, 0x5

    .line 70
    invoke-virtual {v3, v4}, Landroid/media/AudioAttributes$Builder;->setUsage(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v3

    .line 71
    invoke-virtual {v3, v5}, Landroid/media/AudioAttributes$Builder;->setContentType(I)Landroid/media/AudioAttributes$Builder;

    move-result-object v3

    invoke-virtual {v3}, Landroid/media/AudioAttributes$Builder;->build()Landroid/media/AudioAttributes;

    move-result-object v3

    .line 72
    invoke-virtual {v1, v2, v3}, Landroid/app/NotificationChannel;->setSound(Landroid/net/Uri;Landroid/media/AudioAttributes;)V

    .line 73
    invoke-virtual {v0, v1}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V

    goto :goto_8

    .line 63
    nop

    :array_5e
    .array-data 8
        0x0
        0xb4
        0x78
        0xb4
    .end array-data
.end method

.method static esUltimoDomingo(Ljava/util/Calendar;)Z
    .registers 5

    .prologue
    const/4 v3, 0x2

    .line 111
    invoke-virtual {p0}, Ljava/util/Calendar;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Calendar;

    .line 112
    const/4 v1, 0x5

    const/4 v2, 0x7

    invoke-virtual {v0, v1, v2}, Ljava/util/Calendar;->add(II)V

    .line 113
    invoke-virtual {v0, v3}, Ljava/util/Calendar;->get(I)I

    move-result v0

    invoke-virtual {p0, v3}, Ljava/util/Calendar;->get(I)I

    move-result v1

    if-eq v0, v1, :cond_18

    const/4 v0, 0x1

    :goto_17
    return v0

    :cond_18
    const/4 v0, 0x0

    goto :goto_17
.end method

.method static hora(Landroid/content/Context;Ljava/lang/String;)I
    .registers 5

    .prologue
    .line 78
    invoke-static {p0}, Lcom/finanzas/iglesia/Recordatorios;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "_h"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v0, "semanal"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_26

    const/16 v0, 0x8

    :goto_21
    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    return v0

    :cond_26
    const/16 v0, 0xb

    goto :goto_21
.end method

.method static logo(Landroid/content/Context;)Landroid/graphics/Bitmap;
    .registers 8

    .prologue
    const/4 v1, 0x0

    .line 142
    const/high16 v0, 0x42400000    # 48.0f

    :try_start_3
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v2

    iget v2, v2, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr v0, v2

    float-to-int v2, v0

    .line 143
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v3, 0x7f020005

    const/4 v4, 0x0

    invoke-virtual {v0, v3, v4}, Landroid/content/res/Resources;->getDrawable(ILandroid/content/res/Resources$Theme;)Landroid/graphics/drawable/Drawable;

    move-result-object v3

    .line 144
    sget-object v0, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v2, v2, v0}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 145
    new-instance v4, Landroid/graphics/Canvas;

    invoke-direct {v4, v0}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    .line 146
    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-virtual {v3, v5, v6, v2, v2}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    .line 147
    invoke-virtual {v3, v4}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V
    :try_end_2e
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_2e} :catch_2f

    .line 149
    :goto_2e
    return-object v0

    :catch_2f
    move-exception v0

    move-object v0, v1

    goto :goto_2e
.end method

.method static minuto(Landroid/content/Context;Ljava/lang/String;)I
    .registers 5

    .prologue
    .line 79
    invoke-static {p0}, Lcom/finanzas/iglesia/Recordatorios;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "_m"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v0, "semanal"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_25

    const/4 v0, 0x0

    :goto_20
    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    return v0

    :cond_25
    const/16 v0, 0x1e

    goto :goto_20
.end method

.method public static mostrar(Landroid/content/Context;Ljava/lang/String;)V
    .registers 14

    .prologue
    .line 153
    invoke-static {p0}, Lcom/finanzas/iglesia/Recordatorios;->crearCanal(Landroid/content/Context;)V

    .line 154
    const-string v0, "mensual"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    .line 155
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v0

    .line 156
    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Ljava/util/Calendar;->get(I)I

    move-result v0

    .line 158
    if-eqz v8, :cond_128

    .line 159
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Cierre de "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Lcom/finanzas/iglesia/Recordatorios;->MESES:[Ljava/lang/String;

    aget-object v2, v2, v0

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    .line 160
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Reporte de "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Lcom/finanzas/iglesia/Recordatorios;->MESES_T:[Ljava/lang/String;

    aget-object v0, v2, v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 161
    const-string v5, "\u00daltimo domingo del mes. Gener\u00e1 y compart\u00ed el reporte de ofrendas con la iglesia."

    .line 162
    const-string v4, "Generar reporte"

    .line 163
    const-string v1, "reportes"

    .line 164
    const-string v0, "\u00abH\u00e1gase todo decentemente y con orden.\u00bb \u2014 1 Corintios 14:40"

    move-object v2, v0

    move-object v3, v1

    .line 173
    :goto_4c
    if-eqz v8, :cond_138

    const/16 v0, 0x66

    move v1, v0

    .line 174
    :goto_51
    invoke-static {p0, v3, v1}, Lcom/finanzas/iglesia/Recordatorios;->piAbrir(Landroid/content/Context;Ljava/lang/String;I)Landroid/app/PendingIntent;

    move-result-object v3

    .line 175
    add-int/lit8 v0, v1, 0xa

    invoke-static {p0, p1, v0}, Lcom/finanzas/iglesia/Recordatorios;->piPosponer(Landroid/content/Context;Ljava/lang/String;I)Landroid/app/PendingIntent;

    move-result-object v0

    .line 177
    new-instance v8, Landroid/widget/RemoteViews;

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v9

    const/high16 v10, 0x7f050000

    invoke-direct {v8, v9, v10}, Landroid/widget/RemoteViews;-><init>(Ljava/lang/String;I)V

    .line 178
    const v9, 0x7f010005

    invoke-virtual {v8, v9, v6}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V

    .line 179
    const v9, 0x7f010004

    invoke-virtual {v8, v9, v5}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V

    .line 181
    new-instance v9, Landroid/widget/RemoteViews;

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v10

    const v11, 0x7f050001

    invoke-direct {v9, v10, v11}, Landroid/widget/RemoteViews;-><init>(Ljava/lang/String;I)V

    .line 182
    const v10, 0x7f010002

    invoke-virtual {v9, v10, v7}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V

    .line 183
    const v7, 0x7f010005

    invoke-virtual {v9, v7, v6}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V

    .line 184
    const v7, 0x7f010004

    invoke-virtual {v9, v7, v5}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V

    .line 185
    const v7, 0x7f010001

    invoke-virtual {v9, v7, v2}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V

    .line 186
    const/high16 v2, 0x7f010000

    invoke-virtual {v9, v2, v4}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V

    .line 187
    const/high16 v2, 0x7f010000

    invoke-virtual {v9, v2, v3}, Landroid/widget/RemoteViews;->setOnClickPendingIntent(ILandroid/app/PendingIntent;)V

    .line 188
    const v2, 0x7f010003

    invoke-virtual {v9, v2, v0}, Landroid/widget/RemoteViews;->setOnClickPendingIntent(ILandroid/app/PendingIntent;)V

    .line 190
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1a

    if-lt v0, v2, :cond_13d

    .line 191
    new-instance v0, Landroid/app/Notification$Builder;

    const-string v2, "recordatorios_domingo"

    invoke-direct {v0, p0, v2}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    move-object v2, v0

    .line 192
    :goto_b4
    const v0, 0x7f020006

    invoke-virtual {v2, v0}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;

    move-result-object v0

    .line 193
    invoke-static {p0}, Lcom/finanzas/iglesia/Recordatorios;->logo(Landroid/content/Context;)Landroid/graphics/Bitmap;

    move-result-object v4

    invoke-virtual {v0, v4}, Landroid/app/Notification$Builder;->setLargeIcon(Landroid/graphics/Bitmap;)Landroid/app/Notification$Builder;

    move-result-object v0

    const-string v4, "#57534e"

    .line 194
    invoke-static {v4}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v4

    invoke-virtual {v0, v4}, Landroid/app/Notification$Builder;->setColor(I)Landroid/app/Notification$Builder;

    move-result-object v0

    .line 195
    invoke-virtual {v0, v6}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v0

    .line 196
    invoke-virtual {v0, v5}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v0

    const-string v4, "Finanzas Iglesia"

    .line 197
    invoke-virtual {v0, v4}, Landroid/app/Notification$Builder;->setSubText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v0

    .line 198
    invoke-virtual {v0, v8}, Landroid/app/Notification$Builder;->setCustomContentView(Landroid/widget/RemoteViews;)Landroid/app/Notification$Builder;

    move-result-object v0

    .line 199
    invoke-virtual {v0, v8}, Landroid/app/Notification$Builder;->setCustomHeadsUpContentView(Landroid/widget/RemoteViews;)Landroid/app/Notification$Builder;

    move-result-object v0

    .line 200
    invoke-virtual {v0, v9}, Landroid/app/Notification$Builder;->setCustomBigContentView(Landroid/widget/RemoteViews;)Landroid/app/Notification$Builder;

    move-result-object v0

    .line 201
    invoke-virtual {v0, v3}, Landroid/app/Notification$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;

    move-result-object v0

    const/4 v3, 0x1

    .line 202
    invoke-virtual {v0, v3}, Landroid/app/Notification$Builder;->setAutoCancel(Z)Landroid/app/Notification$Builder;

    move-result-object v0

    const-string v3, "reminder"

    .line 203
    invoke-virtual {v0, v3}, Landroid/app/Notification$Builder;->setCategory(Ljava/lang/String;)Landroid/app/Notification$Builder;

    move-result-object v0

    const/4 v3, 0x1

    .line 204
    invoke-virtual {v0, v3}, Landroid/app/Notification$Builder;->setVisibility(I)Landroid/app/Notification$Builder;

    move-result-object v0

    const/4 v3, 0x1

    .line 205
    invoke-virtual {v0, v3}, Landroid/app/Notification$Builder;->setShowWhen(Z)Landroid/app/Notification$Builder;

    .line 206
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x1a

    if-ge v0, v3, :cond_118

    .line 207
    const/4 v0, 0x1

    invoke-virtual {v2, v0}, Landroid/app/Notification$Builder;->setPriority(I)Landroid/app/Notification$Builder;

    move-result-object v0

    const/4 v3, 0x1

    .line 208
    invoke-virtual {v0, v3}, Landroid/app/Notification$Builder;->setDefaults(I)Landroid/app/Notification$Builder;

    move-result-object v0

    const/4 v3, 0x4

    new-array v3, v3, [J

    fill-array-data v3, :array_146

    .line 209
    invoke-virtual {v0, v3}, Landroid/app/Notification$Builder;->setVibrate([J)Landroid/app/Notification$Builder;

    .line 211
    :cond_118
    const-string v0, "notification"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    .line 212
    invoke-virtual {v2}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    .line 213
    return-void

    .line 166
    :cond_128
    const-string v7, "Domingo de culto"

    .line 167
    const-string v6, "\u00a1Feliz domingo!"

    .line 168
    const-string v5, "No te olvides de registrar las ofrendas de Santa Cena y Escuela Dominical de hoy."

    .line 169
    const-string v4, "Registrar ofrendas"

    .line 170
    const-string v1, "agregar"

    .line 171
    const-string v0, "\u00abDios ama al dador alegre.\u00bb \u2014 2 Corintios 9:7"

    move-object v2, v0

    move-object v3, v1

    goto/16 :goto_4c

    .line 173
    :cond_138
    const/16 v0, 0x65

    move v1, v0

    goto/16 :goto_51

    .line 191
    :cond_13d
    new-instance v0, Landroid/app/Notification$Builder;

    invoke-direct {v0, p0}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;)V

    move-object v2, v0

    goto/16 :goto_b4

    .line 208
    nop

    :array_146
    .array-data 8
        0x0
        0xb4
        0x78
        0xb4
    .end array-data
.end method

.method static piAbrir(Landroid/content/Context;Ljava/lang/String;I)Landroid/app/PendingIntent;
    .registers 5

    .prologue
    .line 129
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/finanzas/iglesia/MainActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "abrir"

    .line 130
    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    const/high16 v1, 0x14000000

    .line 131
    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    move-result-object v0

    .line 132
    const/high16 v1, 0xc000000

    invoke-static {p0, p2, v0, v1}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v0

    return-object v0
.end method

.method static piAlarma(Landroid/content/Context;Ljava/lang/String;I)Landroid/app/PendingIntent;
    .registers 5

    .prologue
    .line 83
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/finanzas/iglesia/AlarmaReceiver;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.finanzas.iglesia.ALARMA"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    const-string v1, "tipo"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    .line 84
    const/high16 v1, 0xc000000

    invoke-static {p0, p2, v0, v1}, Landroid/app/PendingIntent;->getBroadcast(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v0

    return-object v0
.end method

.method static piPosponer(Landroid/content/Context;Ljava/lang/String;I)Landroid/app/PendingIntent;
    .registers 5

    .prologue
    .line 136
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/finanzas/iglesia/AlarmaReceiver;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.finanzas.iglesia.POSPONER"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    const-string v1, "tipo"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    .line 137
    const/high16 v1, 0xc000000

    invoke-static {p0, p2, v0, v1}, Landroid/app/PendingIntent;->getBroadcast(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v0

    return-object v0
.end method

.method static poner(Landroid/app/AlarmManager;JLandroid/app/PendingIntent;)V
    .registers 7

    .prologue
    const/4 v1, 0x0

    .line 100
    const/4 v0, 0x0

    :try_start_2
    invoke-virtual {p0, v0, p1, p2, p3}, Landroid/app/AlarmManager;->setExactAndAllowWhileIdle(IJLandroid/app/PendingIntent;)V
    :try_end_5
    .catch Ljava/lang/SecurityException; {:try_start_2 .. :try_end_5} :catch_6

    .line 102
    :goto_5
    return-void

    .line 101
    :catch_6
    move-exception v0

    invoke-virtual {p0, v1, p1, p2, p3}, Landroid/app/AlarmManager;->setAndAllowWhileIdle(IJLandroid/app/PendingIntent;)V

    goto :goto_5
.end method

.method static posponer(Landroid/content/Context;Ljava/lang/String;)V
    .registers 8

    .prologue
    .line 105
    const-string v0, "alarm"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/AlarmManager;

    .line 106
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "_pospuesto"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v1, "semanal"

    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_34

    const/4 v1, 0x3

    :goto_24
    invoke-static {p0, v2, v1}, Lcom/finanzas/iglesia/Recordatorios;->piAlarma(Landroid/content/Context;Ljava/lang/String;I)Landroid/app/PendingIntent;

    move-result-object v1

    .line 107
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    const-wide/32 v4, 0x36ee80

    add-long/2addr v2, v4

    invoke-static {v0, v2, v3, v1}, Lcom/finanzas/iglesia/Recordatorios;->poner(Landroid/app/AlarmManager;JLandroid/app/PendingIntent;)V

    .line 108
    return-void

    .line 106
    :cond_34
    const/4 v1, 0x4

    goto :goto_24
.end method

.method static prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
    .registers 3

    .prologue
    .line 54
    const-string v0, "recordatorios"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    return-object v0
.end method

.method public static programar(Landroid/content/Context;)V
    .registers 13

    .prologue
    const/4 v3, 0x2

    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 88
    const-string v0, "alarm"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/AlarmManager;

    .line 89
    new-array v5, v3, [Ljava/lang/String;

    const-string v4, "semanal"

    aput-object v4, v5, v1

    const-string v4, "mensual"

    aput-object v4, v5, v2

    .line 90
    array-length v6, v5

    move v4, v1

    :goto_17
    if-ge v4, v6, :cond_4b

    aget-object v7, v5, v4

    .line 91
    const-string v1, "semanal"

    invoke-virtual {v1, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_35

    move v1, v2

    :goto_24
    invoke-static {p0, v7, v1}, Lcom/finanzas/iglesia/Recordatorios;->piAlarma(Landroid/content/Context;Ljava/lang/String;I)Landroid/app/PendingIntent;

    move-result-object v1

    .line 92
    invoke-virtual {v0, v1}, Landroid/app/AlarmManager;->cancel(Landroid/app/PendingIntent;)V

    .line 93
    invoke-static {p0, v7}, Lcom/finanzas/iglesia/Recordatorios;->activo(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v8

    if-nez v8, :cond_37

    .line 90
    :goto_31
    add-int/lit8 v1, v4, 0x1

    move v4, v1

    goto :goto_17

    :cond_35
    move v1, v3

    .line 91
    goto :goto_24

    .line 94
    :cond_37
    invoke-static {p0, v7}, Lcom/finanzas/iglesia/Recordatorios;->hora(Landroid/content/Context;Ljava/lang/String;)I

    move-result v8

    invoke-static {p0, v7}, Lcom/finanzas/iglesia/Recordatorios;->minuto(Landroid/content/Context;Ljava/lang/String;)I

    move-result v9

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v10

    invoke-static {v7, v8, v9, v10, v11}, Lcom/finanzas/iglesia/Recordatorios;->proximo(Ljava/lang/String;IIJ)J

    move-result-wide v8

    .line 95
    invoke-static {v0, v8, v9, v1}, Lcom/finanzas/iglesia/Recordatorios;->poner(Landroid/app/AlarmManager;JLandroid/app/PendingIntent;)V

    goto :goto_31

    .line 97
    :cond_4b
    return-void
.end method

.method static proximo(Ljava/lang/String;IIJ)J
    .registers 12

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    const/4 v5, 0x7

    const/4 v4, 0x5

    .line 117
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v0

    .line 118
    invoke-virtual {v0, p3, p4}, Ljava/util/Calendar;->setTimeInMillis(J)V

    .line 119
    const/16 v1, 0xb

    invoke-virtual {v0, v1, p1}, Ljava/util/Calendar;->set(II)V

    const/16 v1, 0xc

    invoke-virtual {v0, v1, p2}, Ljava/util/Calendar;->set(II)V

    .line 120
    const/16 v1, 0xd

    invoke-virtual {v0, v1, v2}, Ljava/util/Calendar;->set(II)V

    const/16 v1, 0xe

    invoke-virtual {v0, v1, v2}, Ljava/util/Calendar;->set(II)V

    .line 121
    :goto_1f
    invoke-virtual {v0, v5}, Ljava/util/Calendar;->get(I)I

    move-result v1

    if-eq v1, v3, :cond_29

    invoke-virtual {v0, v4, v3}, Ljava/util/Calendar;->add(II)V

    goto :goto_1f

    .line 122
    :cond_29
    invoke-virtual {v0}, Ljava/util/Calendar;->getTimeInMillis()J

    move-result-wide v2

    cmp-long v1, v2, p3

    if-gtz v1, :cond_34

    invoke-virtual {v0, v4, v5}, Ljava/util/Calendar;->add(II)V

    .line 123
    :cond_34
    const-string v1, "mensual"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_46

    :goto_3c
    invoke-static {v0}, Lcom/finanzas/iglesia/Recordatorios;->esUltimoDomingo(Ljava/util/Calendar;)Z

    move-result v1

    if-nez v1, :cond_46

    invoke-virtual {v0, v4, v5}, Ljava/util/Calendar;->add(II)V

    goto :goto_3c

    .line 124
    :cond_46
    invoke-virtual {v0}, Ljava/util/Calendar;->getTimeInMillis()J

    move-result-wide v0

    return-wide v0
.end method


.method static piAbrirMsg(Landroid/content/Context;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)Landroid/app/PendingIntent;
    .registers 7

    new-instance v0, Landroid/content/Intent;
    const-class v1, Lcom/finanzas/iglesia/MainActivity;
    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
    const-string v1, "abrir"
    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;
    const-string v1, "msg"
    invoke-virtual {v0, v1, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;
    const-string v1, "pdf"
    invoke-virtual {v0, v1, p4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;
    const/high16 v1, 0x14000000
    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;
    const/high16 v1, 0xc000000
    invoke-static {p0, p2, v0, v1}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;
    move-result-object v0
    return-object v0
.end method

.method public static notificarReporte(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .registers 12

    invoke-static {p0}, Lcom/finanzas/iglesia/Recordatorios;->crearCanal(Landroid/content/Context;)V

    const-string v0, "reportes"
    const/16 v1, 0x67
    invoke-static {p0, v0, v1, p3, p4}, Lcom/finanzas/iglesia/Recordatorios;->piAbrirMsg(Landroid/content/Context;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)Landroid/app/PendingIntent;
    move-result-object v2

    const-string v3, "Ver reportes"
    if-eqz p4, :sin_pdf
    invoke-virtual {p4}, Ljava/lang/String;->isEmpty()Z
    move-result v0
    if-nez v0, :sin_pdf
    const-string v3, "Abrir PDF"
    :sin_pdf

    # Vista chica (y emergente)
    new-instance v4, Landroid/widget/RemoteViews;
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;
    move-result-object v0
    const/high16 v1, 0x7f050000
    invoke-direct {v4, v0, v1}, Landroid/widget/RemoteViews;-><init>(Ljava/lang/String;I)V
    const v1, 0x7f010005
    invoke-virtual {v4, v1, p1}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V
    const v1, 0x7f010004
    invoke-virtual {v4, v1, p2}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V

    # Vista grande
    new-instance v5, Landroid/widget/RemoteViews;
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;
    move-result-object v0
    const v1, 0x7f050001
    invoke-direct {v5, v0, v1}, Landroid/widget/RemoteViews;-><init>(Ljava/lang/String;I)V
    const-string v0, "Reporte listo"
    const v1, 0x7f010002
    invoke-virtual {v5, v1, v0}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V
    const v1, 0x7f010005
    invoke-virtual {v5, v1, p1}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V
    const v1, 0x7f010004
    invoke-virtual {v5, v1, p2}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V
    const-string v0, "\u00abHacedlo todo de coraz\u00f3n, como para el Se\u00f1or.\u00bb \u2014 Colosenses 3:23"
    const v1, 0x7f010001
    invoke-virtual {v5, v1, v0}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V
    const v1, 0x7f010000
    invoke-virtual {v5, v1, v3}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V
    invoke-virtual {v5, v1, v2}, Landroid/widget/RemoteViews;->setOnClickPendingIntent(ILandroid/app/PendingIntent;)V
    const v1, 0x7f010003
    const/16 v0, 0x8
    invoke-virtual {v5, v1, v0}, Landroid/widget/RemoteViews;->setViewVisibility(II)V

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v1, 0x1a
    if-lt v0, v1, :builder_viejo
    new-instance v6, Landroid/app/Notification$Builder;
    const-string v0, "recordatorios_domingo"
    invoke-direct {v6, p0, v0}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V
    goto :builder_listo
    :builder_viejo
    new-instance v6, Landroid/app/Notification$Builder;
    invoke-direct {v6, p0}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;)V
    const/4 v0, 0x1
    invoke-virtual {v6, v0}, Landroid/app/Notification$Builder;->setPriority(I)Landroid/app/Notification$Builder;
    const/4 v0, -0x1
    invoke-virtual {v6, v0}, Landroid/app/Notification$Builder;->setDefaults(I)Landroid/app/Notification$Builder;
    :builder_listo

    const v0, 0x7f020006
    invoke-virtual {v6, v0}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;
    invoke-static {p0}, Lcom/finanzas/iglesia/Recordatorios;->logo(Landroid/content/Context;)Landroid/graphics/Bitmap;
    move-result-object v0
    invoke-virtual {v6, v0}, Landroid/app/Notification$Builder;->setLargeIcon(Landroid/graphics/Bitmap;)Landroid/app/Notification$Builder;
    const-string v0, "#57534e"
    invoke-static {v0}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I
    move-result v0
    invoke-virtual {v6, v0}, Landroid/app/Notification$Builder;->setColor(I)Landroid/app/Notification$Builder;
    invoke-virtual {v6, p1}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;
    invoke-virtual {v6, p2}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;
    const-string v0, "Finanzas Iglesia"
    invoke-virtual {v6, v0}, Landroid/app/Notification$Builder;->setSubText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;
    invoke-virtual {v6, v4}, Landroid/app/Notification$Builder;->setCustomContentView(Landroid/widget/RemoteViews;)Landroid/app/Notification$Builder;
    invoke-virtual {v6, v4}, Landroid/app/Notification$Builder;->setCustomHeadsUpContentView(Landroid/widget/RemoteViews;)Landroid/app/Notification$Builder;
    invoke-virtual {v6, v5}, Landroid/app/Notification$Builder;->setCustomBigContentView(Landroid/widget/RemoteViews;)Landroid/app/Notification$Builder;
    invoke-virtual {v6, v2}, Landroid/app/Notification$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;
    const/4 v0, 0x1
    invoke-virtual {v6, v0}, Landroid/app/Notification$Builder;->setAutoCancel(Z)Landroid/app/Notification$Builder;
    invoke-virtual {v6, v0}, Landroid/app/Notification$Builder;->setVisibility(I)Landroid/app/Notification$Builder;
    invoke-virtual {v6, v0}, Landroid/app/Notification$Builder;->setShowWhen(Z)Landroid/app/Notification$Builder;
    const-string v0, "status"
    invoke-virtual {v6, v0}, Landroid/app/Notification$Builder;->setCategory(Ljava/lang/String;)Landroid/app/Notification$Builder;

    const-string v0, "notification"
    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Landroid/app/NotificationManager;
    invoke-virtual {v6}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;
    move-result-object v1
    const/16 v3, 0x67
    invoke-virtual {v0, v3, v1}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V
    return-void
.end method
