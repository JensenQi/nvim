import React from 'react';
import { Card, Icon, MD3Colors, Text } from 'react-native-paper';

export default function (props: { title: string; icon: string; onPress?: () => void }) {
    return (
        <Card onPress={props.onPress}>
            <Card.Content style={{ alignItems: 'center' }}>
                <Icon source={props.icon} color={MD3Colors.primary0} size={20} />
                <Text>{props.title}</Text>
            </Card.Content>
        </Card>
    );
}
