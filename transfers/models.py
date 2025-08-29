from django.db import models
from accounts.models import Account


TRANSFER_CATEGORIES = (
    ('doc', 'DOC'),
    ('ted', 'TED'),
    ('pix', 'Pix'),
)


class Transfer(models.Model):
    description = models.CharField(
        max_length=200,
        null=False,
        blank=False,
        verbose_name="Descrição"
    )
    value = models.DecimalField(
        verbose_name="Valor",
        null=False,
        blank=False,
        decimal_places=2,
        max_digits=10
    )
    date = models.DateField(
        verbose_name="Data",
        null=False,
        blank=False
    )
    horary = models.TimeField(
        verbose_name="Horário",
        null=False,
        blank=False
    )
    category = models.CharField(
        max_length=200,
        choices=TRANSFER_CATEGORIES,
        null=False,
        blank=False,
        verbose_name="Categoria"
    )
    origin_account = models.ForeignKey(
        Account,
        on_delete=models.PROTECT,
        null=False,
        blank=False,
        verbose_name="Conta de Origem",
        related_name="Credora"
    )
    destiny_account = models.ForeignKey(
        Account,
        on_delete=models.PROTECT,
        null=False,
        blank=False,
        verbose_name="Conta de Destino",
        related_name="Beneficiada"
    )
    transfered = models.BooleanField(
        verbose_name="Transferido"
    )

    class Meta:
        ordering = ['-id']
        verbose_name = "Transferência"
        verbose_name_plural = "Transferências"

    def __str__(self):
        return f"""{
            self.description
            },{
                self.category
            } - {
                self.date
            },{
                self.horary
            }: [{
                self.origin_account
            } -> {
                self.destiny_account
            }]
        """
