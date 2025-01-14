from django.contrib import admin
from .models import *
from django.contrib.auth.admin import UserAdmin


@admin.register(CustomUser)
class CustomUserAdmin(UserAdmin):
    list_display = ('username', 'email')
    list_display_links = ('username', 'email')
