from rest_framework import serializers
from revenues.models import Revenue


class RevenueSerializer(serializers.ModelSerializer):
    class Meta:
        model = Revenue
        fields = [
            'id', 'description', 'value', 'date', 'horary',
            'category', 'account', 'received', 'source',
            'tax_amount', 'net_amount', 'member', 'receipt',
            'recurring', 'frequency', 'notes'
        ]
        read_only_fields = ['id', 'net_amount']
