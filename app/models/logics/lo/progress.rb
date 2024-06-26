module Logics
  module Lo
    class Progress
      def initialize(lo)
        @lo = lo
        @pages = lo.pages.all
      end

      def completed(user, team = nil)
        visualized_pages = get_page_visualizations(user, team)
        completed_solution_steps = completed_solution_steps(user, team)

        completed_items = visualized_pages.size + completed_solution_steps.size
        total_items = total_items_count

        (completed_items / total_items.to_f) * 100
      end

      def explored(user, team = nil)
        visualizations = visualizations(user, team)
        total_items = total_items_count

        (visualizations.size / total_items.to_f) * 100
      end

      def unexplored(user, team = nil)
        visualizations = visualizations(user, team)
        total_items = total_items_count

        ((total_items - visualizations.size) / total_items.to_f) * 100
      end

      private

      def visualizations(user, team = nil)
        page_visualizations = get_page_visualizations(user, team)
        solution_step_visualizations = get_solution_step_visualizations(user, team)

        page_visualizations + solution_step_visualizations
      end

      def get_page_visualizations(user, team = nil)
        visualizations = @pages.select { |page| page.respond_to?(:visualizations) }.flat_map(&:visualizations)
        filter_visualizations(visualizations, user, team)
      end

      def get_solution_step_visualizations(user, team = nil)
        solution_steps = extract_solution_steps(@pages)
        visualizations = solution_steps.select { |step| step.respond_to?(:visualizations) }.flat_map(&:visualizations)
        filter_visualizations(visualizations, user, team)
      end

      def completed_solution_steps(user, team = nil)
        solution_steps = extract_solution_steps(@pages)
        completed_steps = solution_steps.select do |step|
          step.answers.any? { |answer| answer.correct && answer.user == user && (team.nil? || answer.team == team) }
        end
        filter_visualizations(completed_steps.flat_map(&:visualizations), user, team)
      end

      def extract_solution_steps(pages)
        pages.select { |page| page.respond_to?(:solution_steps) }.flat_map(&:solution_steps)
      end

      def filter_visualizations(visualizations, user, team)
        visualizations.select do |visualization|
          visualization.user == user && (team.nil? || visualization.team == team)
        end
      end

      def total_items_count
        page_count = @pages.size
        solution_step_count = extract_solution_steps(@pages).size
        page_count + solution_step_count
      end
    end
  end
end
