# Generated by Django 4.2.17 on 2025-01-15 10:37

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0002_customuser_uniq_code'),
    ]

    operations = [
        migrations.AlterField(
            model_name='customuser',
            name='uniq_code',
            field=models.CharField(blank=True, max_length=50, null=True, unique=True),
        ),
    ]
