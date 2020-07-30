# frozen_string_literal: true

module Macro
  include Trailblazer

  def self.Validate(params_context_key, with: nil)
    step = lambda do |ctx, **|
      return if ctx[params_context_key].blank?
      return if with.blank?

      contract = with.new
      ctx[:validation_result] = contract.call(ctx[params_context_key])

      ctx[params_context_key] = ctx[:validation_result].to_h
      return handle_validation_errors(ctx)
    end

    task = Activity::TaskBuilder::Binary(step)

    { task: task, id: "params.validate" }
  end

  private

  def self.handle_validation_errors(ctx, wrap_errors_key = nil)
    return true if ctx[:validation_result].success?

    ctx[:error] = "Validation error: #{ctx[:validation_result].errors}"
    false
  end

end
