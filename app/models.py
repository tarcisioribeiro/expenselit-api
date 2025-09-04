import uuid
from django.db import models
from django.contrib.auth.models import User


class BaseModel(models.Model):
    """
    Modelo base abstrato com campos comuns para auditoria e controle.
    Attributes
    ----------
    uuid : UUIDField
        Identificador único universal do registro.
    created_at : DateTimeField
        Data e hora de criação do registro.
    updated_at : DateTimeField
        Data e hora da última atualização do registro.
    created_by : ForeignKey
        Usuário que criou o registro.
    updated_by : ForeignKey
        Usuário que fez a última atualização do registro.
    is_deleted : BooleanField
        Flag para indicar se o registro foi excluído (soft delete).
    deleted_at : DateTimeField
        Data e hora da exclusão do registro.
    """
    uuid = models.UUIDField(
        default=uuid.uuid4,
        editable=False,
        unique=True,
        verbose_name="UUID"
    )
    created_at = models.DateTimeField(
        auto_now_add=True,
        verbose_name="Criado em"
    )
    updated_at = models.DateTimeField(
        auto_now=True,
        verbose_name="Atualizado em"
    )
    created_by = models.ForeignKey(
        User,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="%(class)s_created",
        verbose_name="Criado por"
    )
    updated_by = models.ForeignKey(
        User,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="%(class)s_updated",
        verbose_name="Atualizado por"
    )
    is_deleted = models.BooleanField(
        default=False,
        verbose_name="Excluído"
    )
    deleted_at = models.DateTimeField(
        null=True,
        blank=True,
        verbose_name="Excluído em"
    )

    class Meta:
        abstract = True


# Choices comuns
PAYMENT_FREQUENCY_CHOICES = (
    ('daily', 'Diário'),
    ('weekly', 'Semanal'),
    ('monthly', 'Mensal'),
    ('quarterly', 'Trimestral'),
    ('semiannual', 'Semestral'),
    ('annual', 'Anual')
)

PAYMENT_METHOD_CHOICES = (
    ('cash', 'Dinheiro'),
    ('debit_card', 'Cartão de Débito'),
    ('credit_card', 'Cartão de Crédito'),
    ('pix', 'PIX'),
    ('transfer', 'Transferência'),
    ('check', 'Cheque'),
    ('other', 'Outro')
)

LOAN_STATUS_CHOICES = (
    ('active', 'Ativo'),
    ('paid', 'Quitado'),
    ('overdue', 'Em atraso'),
    ('cancelled', 'Cancelado')
)

BILL_STATUS_CHOICES = (
    ('open', 'Aberta'),
    ('closed', 'Fechada'),
    ('paid', 'Paga'),
    ('overdue', 'Em atraso')
)
