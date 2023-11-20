module ActionsMessages
  extend ActiveSupport::Concern

  def success_create_message(gender: 'm', model: nil)
    I18n.t("messages.actions.create.#{gender}", entity: model_human(model))
  end

  def feminine_success_create_message(model: nil)
    success_create_message(gender: 'f', model: model)
  end

  def success_update_message(gender: 'm', model: nil)
    I18n.t("messages.actions.update.#{gender}", entity: model_human(model))
  end

  def feminine_success_update_message(model: nil)
    success_update_message(gender: 'f', model: model)
  end

  def success_destroy_message(gender: 'm', model: nil)
    I18n.t("messages.actions.destroy.#{gender}", entity: model_human(model))
  end

  def feminine_success_destroy_message(model: nil)
    success_destroy_message(gender: 'f', model: model)
  end

  def unsuccess_destroy_message(gender: 'm', model: nil)
    I18n.t("messages.actions.destroy.not_found.#{gender}", entity: model_human(model))
  end

  def feminine_unsuccess_destroy_message(model: nil)
    success_destroy_message(gender: 'f', model: model)
  end

  # def success_duplicate_message(gender: 'm', model: nil)
  #   I18n.t("messages.actions.duplicate.#{gender}", entity: model_human(model))
  # end

  # def feminine_success_duplicate_message(model: nil)
  #   success_duplicate_message(gender: 'f', model: model)
  # end

  # def unsuccess_duplicate_message(gender: 'm', model: nil)
  #   I18n.t("messages.actions.duplicate.not_found.#{gender}", entity: model_human(model))
  # end

  # def feminine_unsuccess_duplicate_message(model: nil)
  #   success_duplicate_message(gender: 'f', model: model)
  # end

  def destroy_bond_message(model: nil)
    I18n.t('messages.actions.destroy.bond', entity: model_human(model))
  end

  def error_message
    I18n.t('messages.actions.errors')
  end

  private

  def model_human(model)
    model ||= controller_name.classify.constantize
    model.model_name.human
  end
end
