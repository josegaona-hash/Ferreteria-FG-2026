.class public final Lcom/finanzas/iglesia/Recordatorios$Puente;
.super Ljava/lang/Object;
.source "Recordatorios.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/finanzas/iglesia/Recordatorios;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Puente"
.end annotation


# instance fields
.field private final c:Landroid/content/Context;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .registers 2

    .prologue
    .line 218
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/finanzas/iglesia/Recordatorios$Puente;->c:Landroid/content/Context;

    return-void
.end method


# virtual methods
.method public abrirAjustes()V
    .registers 5
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .prologue
    .line 270
    :try_start_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt v0, v1, :cond_24

    .line 271
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.settings.APP_NOTIFICATION_SETTINGS"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v1, "android.provider.extra.APP_PACKAGE"

    iget-object v2, p0, Lcom/finanzas/iglesia/Recordatorios$Puente;->c:Landroid/content/Context;

    .line 272
    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    .line 276
    :goto_19
    const/high16 v1, 0x10000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 277
    iget-object v1, p0, Lcom/finanzas/iglesia/Recordatorios$Puente;->c:Landroid/content/Context;

    invoke-virtual {v1, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    .line 279
    :goto_23
    return-void

    .line 274
    :cond_24
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.settings.APPLICATION_DETAILS_SETTINGS"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "package:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/finanzas/iglesia/Recordatorios$Puente;->c:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V
    :try_end_48
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_48} :catch_49

    goto :goto_19

    .line 278
    :catch_49
    move-exception v0

    goto :goto_23
.end method

.method public config()Ljava/lang/String;
    .registers 9
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .prologue
    const/4 v0, 0x0

    .line 222
    :try_start_1
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 223
    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/String;

    const/4 v3, 0x0

    const-string v4, "semanal"

    aput-object v4, v2, v3

    const/4 v3, 0x1

    const-string v4, "mensual"

    aput-object v4, v2, v3

    .line 224
    array-length v3, v2

    :goto_14
    if-ge v0, v3, :cond_44

    aget-object v4, v2, v0

    .line 225
    new-instance v5, Lorg/json/JSONObject;

    invoke-direct {v5}, Lorg/json/JSONObject;-><init>()V

    .line 226
    const-string v6, "on"

    iget-object v7, p0, Lcom/finanzas/iglesia/Recordatorios$Puente;->c:Landroid/content/Context;

    invoke-static {v7, v4}, Lcom/finanzas/iglesia/Recordatorios;->activo(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v7

    invoke-virtual {v5, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    const-string v6, "h"

    iget-object v7, p0, Lcom/finanzas/iglesia/Recordatorios$Puente;->c:Landroid/content/Context;

    invoke-static {v7, v4}, Lcom/finanzas/iglesia/Recordatorios;->hora(Landroid/content/Context;Ljava/lang/String;)I

    move-result v7

    invoke-virtual {v5, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v6, "m"

    iget-object v7, p0, Lcom/finanzas/iglesia/Recordatorios$Puente;->c:Landroid/content/Context;

    invoke-static {v7, v4}, Lcom/finanzas/iglesia/Recordatorios;->minuto(Landroid/content/Context;Ljava/lang/String;)I

    move-result v7

    invoke-virtual {v5, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 227
    invoke-virtual {v1, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 224
    add-int/lit8 v0, v0, 0x1

    goto :goto_14

    .line 229
    :cond_44
    const-string v0, "permitidas"

    invoke-virtual {p0}, Lcom/finanzas/iglesia/Recordatorios$Puente;->permitidas()Z

    move-result v2

    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 230
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;
    :try_end_50
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_50} :catch_52

    move-result-object v0

    .line 231
    :goto_51
    return-object v0

    :catch_52
    move-exception v0

    const-string v0, "{}"

    goto :goto_51
.end method

.method public guardar(Ljava/lang/String;)Z
    .registers 16
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 236
    :try_start_2
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 237
    iget-object v2, p0, Lcom/finanzas/iglesia/Recordatorios$Puente;->c:Landroid/content/Context;

    invoke-static {v2}, Lcom/finanzas/iglesia/Recordatorios;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v2

    invoke-interface {v2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v4

    .line 238
    const/4 v2, 0x2

    new-array v5, v2, [Ljava/lang/String;

    const/4 v2, 0x0

    const-string v6, "semanal"

    aput-object v6, v5, v2

    const/4 v2, 0x1

    const-string v6, "mensual"

    aput-object v6, v5, v2

    .line 239
    array-length v6, v5

    move v2, v1

    :goto_20
    if-ge v2, v6, :cond_a8

    aget-object v7, v5, v2

    .line 240
    invoke-virtual {v3, v7}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v8

    .line 241
    if-nez v8, :cond_2d

    .line 239
    :goto_2a
    add-int/lit8 v2, v2, 0x1

    goto :goto_20

    .line 242
    :cond_2d
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, "_on"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    const-string v10, "on"

    const/4 v11, 0x1

    invoke-virtual {v8, v10, v11}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;Z)Z

    move-result v10

    invoke-interface {v4, v9, v10}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    .line 243
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, "_h"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    const/4 v10, 0x0

    const/16 v11, 0x17

    const-string v12, "h"

    iget-object v13, p0, Lcom/finanzas/iglesia/Recordatorios$Puente;->c:Landroid/content/Context;

    invoke-static {v13, v7}, Lcom/finanzas/iglesia/Recordatorios;->hora(Landroid/content/Context;Ljava/lang/String;)I

    move-result v13

    invoke-virtual {v8, v12, v13}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v12

    invoke-static {v11, v12}, Ljava/lang/Math;->min(II)I

    move-result v11

    invoke-static {v10, v11}, Ljava/lang/Math;->max(II)I

    move-result v10

    invoke-interface {v4, v9, v10}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 244
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, "_m"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    const/4 v10, 0x0

    const/16 v11, 0x3b

    const-string v12, "m"

    iget-object v13, p0, Lcom/finanzas/iglesia/Recordatorios$Puente;->c:Landroid/content/Context;

    invoke-static {v13, v7}, Lcom/finanzas/iglesia/Recordatorios;->minuto(Landroid/content/Context;Ljava/lang/String;)I

    move-result v7

    invoke-virtual {v8, v12, v7}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v7

    invoke-static {v11, v7}, Ljava/lang/Math;->min(II)I

    move-result v7

    invoke-static {v10, v7}, Ljava/lang/Math;->max(II)I

    move-result v7

    invoke-interface {v4, v9, v7}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    goto :goto_2a

    .line 249
    :catch_a5
    move-exception v0

    move v0, v1

    :goto_a7
    return v0

    .line 246
    :cond_a8
    invoke-interface {v4}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 247
    iget-object v2, p0, Lcom/finanzas/iglesia/Recordatorios$Puente;->c:Landroid/content/Context;

    invoke-static {v2}, Lcom/finanzas/iglesia/Recordatorios;->programar(Landroid/content/Context;)V
    :try_end_b0
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_b0} :catch_a5

    goto :goto_a7
.end method

.method public permitidas()Z
    .registers 5
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 258
    iget-object v0, p0, Lcom/finanzas/iglesia/Recordatorios$Puente;->c:Landroid/content/Context;

    const-string v2, "notification"

    invoke-virtual {v0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    .line 259
    invoke-virtual {v0}, Landroid/app/NotificationManager;->areNotificationsEnabled()Z

    move-result v2

    if-nez v2, :cond_13

    move v0, v1

    .line 264
    :goto_12
    return v0

    .line 260
    :cond_13
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x1a

    if-lt v2, v3, :cond_29

    .line 261
    const-string v2, "recordatorios_domingo"

    invoke-virtual {v0, v2}, Landroid/app/NotificationManager;->getNotificationChannel(Ljava/lang/String;)Landroid/app/NotificationChannel;

    move-result-object v0

    .line 262
    if-eqz v0, :cond_29

    invoke-virtual {v0}, Landroid/app/NotificationChannel;->getImportance()I

    move-result v0

    if-nez v0, :cond_29

    move v0, v1

    goto :goto_12

    .line 264
    :cond_29
    const/4 v0, 0x1

    goto :goto_12
.end method

.method public probar(Ljava/lang/String;)Z
    .registers 4
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .prologue
    .line 253
    :try_start_0
    iget-object v1, p0, Lcom/finanzas/iglesia/Recordatorios$Puente;->c:Landroid/content/Context;

    const-string v0, "mensual"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_11

    const-string v0, "mensual"

    :goto_c
    invoke-static {v1, v0}, Lcom/finanzas/iglesia/Recordatorios;->mostrar(Landroid/content/Context;Ljava/lang/String;)V

    const/4 v0, 0x1

    .line 254
    :goto_10
    return v0

    .line 253
    :cond_11
    const-string v0, "semanal"
    :try_end_13
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_13} :catch_14

    goto :goto_c

    .line 254
    :catch_14
    move-exception v0

    const/4 v0, 0x0

    goto :goto_10
.end method

.method public notificarReporte(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z
    .registers 7
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    :try_start_0
    iget-object v0, p0, Lcom/finanzas/iglesia/Recordatorios$Puente;->c:Landroid/content/Context;
    invoke-static {v0, p1, p2, p3, p4}, Lcom/finanzas/iglesia/Recordatorios;->notificarReporte(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v0, 0x1
    return v0

    :catch_0
    const/4 v0, 0x0
    return v0
.end method
