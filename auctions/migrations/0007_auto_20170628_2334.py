# -*- coding: utf-8 -*-
# Generated by Django 1.11.2 on 2017-06-28 23:34
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('auctions', '0006_auto_20170628_2150'),
    ]

    operations = [
        migrations.AlterField(
            model_name='auction',
            name='auction_id',
            field=models.CharField(max_length=20, unique=True),
        ),
    ]