<template>
  <div>
    <ejs-schedule
        id="scheduler"
        :event-settings="eventSettings"
        :views="views"
        :start-hour="startHour"
        :end-hour="endHour"
    ></ejs-schedule>
  </div>
</template>

<script>
import { ScheduleComponent, Day, WorkWeek, Month } from '@syncfusion/ej2-vue-schedule';

export default {
  name: "Scheduler",
  components: {
    "ejs-schedule": ScheduleComponent
  },
  data() {
    const schedulerElement = document.getElementById('scheduler');
    const props = schedulerElement ? JSON.parse(schedulerElement.getAttribute('data')) : {};
    const assignments = props.assignments || [];

    console.log('Raw props:', props);
    console.log('Assignments:', assignments);

    return {
      startHour: '07:00',
      endHour: '19:00',
      eventSettings: {
        dataSource: assignments.length > 0 ? assignments : [
          {
            Id: 1,
            Subject: 'Meeting',
            StartTime: new Date(2025, 3, 26, 8, 0),
            EndTime: new Date(2025, 3, 26, 9, 0)
          }
        ]
      },
      views: ['WorkWeek', 'Day', 'Month' ]
    };
  },
  provide: {
    schedule: [Day, WorkWeek, Month]
  }
}
</script>

<style>
@import '@syncfusion/ej2-base/styles/material.css';
@import '@syncfusion/ej2-buttons/styles/material.css';
@import '@syncfusion/ej2-navigations/styles/material.css';
@import '@syncfusion/ej2-popups/styles/material.css';
@import '@syncfusion/ej2-schedule/styles/material.css';
</style>