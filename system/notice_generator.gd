class_name NoticeGenerator extends RefCounted




# Turn Events into Notices




static func event_to_notice(event: Event) -> Notice:

	var title:= ""

	var secondary:= ""

	match event.get_script():

		ItemsAddedToInventoryEvent:

			var item_data = event.data["item_data"]

			var amount = event.data["amount"]

			title = "Item(s) obtained"

			secondary = "%s x%s" % [item_data.get_display_name(), amount]

		ItemsRemovedFromInventoryEvent:

			var item_data = event.data["item_data"]

			var amount = event.data["amount"]

			title = "Item(s) removed"

			secondary = "%s x%s" % [item_data.get_display_name(), amount]

		QuestStartedEvent:

			var quest_data = event.data["quest_data"]

			var quest_def = Quests.get_quest_def(quest_data.quest_id)

			title = "Quest started"

			secondary = quest_def.title

		QuestCompletedEvent:

			var quest_data = event.data["quest_data"]

			var quest_def = Quests.get_quest_def(quest_data.quest_id)

			title = "Quest completed"

			secondary = quest_def.title

	if title == "" or secondary == "":

		return null

	return UI.show_notice(title, secondary)