# -*- coding: utf-8 -*-
# Generated by Django 1.11.2 on 2017-06-28 21:50
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('auctions', '0005_auction_charity'),
    ]

    operations = [
        migrations.AlterField(
            model_name='auction',
            name='charity',
            field=models.CharField(max_length=80),
        ),
    ]