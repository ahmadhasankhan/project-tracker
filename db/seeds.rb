# frozen_string_literal: true

project = Project.create(name: 'New Website', status: 'pending')
project.comments.create(content: 'Initial project created.')
