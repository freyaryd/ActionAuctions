# -*- coding: utf-8 -*-
# Generated by Django 1.11.2 on 2017-06-28 04:25
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('auctions', '0001_initial'),
    ]

    operations = [
        migrations.RenameField(
            model_name='auction',
            old_name='name',
            new_name='location',
        ),
    ]