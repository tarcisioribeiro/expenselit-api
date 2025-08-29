from django.db import models


SEX_OPTION = (
    ('M', 'Masculino'),
    ('F', 'Feminino')
)


class Member(models.Model):
    name = models.CharField(
        max_length=200,
        null=False,
        blank=False,
        verbose_name="Nome"
    )
    document = models.CharField(
        max_length=200,
        blank=False,
        null=False,
        verbose_name="Documento",
        unique=True
    )
    phone = models.CharField(
        max_length=200,
        blank=False,
        null=False,
        verbose_name="Telefone"
    )
    email = models.CharField(
        max_length=200,
        blank=True,
        null=True,
        verbose_name="Email"
    )
    sex = models.CharField(
        max_length=200,
        choices=SEX_OPTION,
        verbose_name="Sexo"
    )
    is_user = models.BooleanField(
        verbose_name="Usuário",
        null=False,
        blank=False,
        default=True
    )
    is_creditor = models.BooleanField(
        verbose_name="Credor",
        null=False,
        blank=False,
        default=True
    )
    is_benefited = models.BooleanField(
        verbose_name="Beneficiário",
        null=False,
        blank=False,
        default=True
    )
    active = models.BooleanField(
        verbose_name="Ativo",
        null=False,
        blank=False,
        default=True
    )

    class Meta:
        verbose_name = "Membro"
        verbose_name_plural = "Membros"

    def __str__(self):
        return self.name
