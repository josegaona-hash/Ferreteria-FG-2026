from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.models import User
from .models import Perfil


@admin.register(Perfil)
class PerfilAdmin(admin.ModelAdmin):
    list_display = ['user', 'empresa', 'cargo', 'telefono']
    list_filter = ['empresa']
    search_fields = ['user__username', 'user__first_name', 'user__last_name']


class PerfilInline(admin.StackedInline):
    model = Perfil
    can_delete = False
    extra = 1
    max_num = 1


admin.site.unregister(User)


@admin.register(User)
class UsuarioAdmin(UserAdmin):
    inlines = [PerfilInline]
