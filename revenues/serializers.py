from rest_framework import serializers
from revenues.models import Revenue


class RevenueSerializer(serializers.ModelSerializer):
    class Meta:
        model = Revenue
        fields = '__all__'
